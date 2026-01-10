#!/bin/bash
set -x
exec > >(tee /var/log/user_data.log) 2>&1


# Wait for network and metadata service to be ready
sleep 30

# Get instance private IP using IMDSv2 (token-based approach)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" 2>/dev/null)

if [ -n "$TOKEN" ]; then
    # IMDSv2 is required
    INSTANCE_PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4)
else
    # Fallback to IMDSv1
    INSTANCE_PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
fi

echo "Instance Private IP: ${INSTANCE_PRIVATE_IP}" >> /var/log/user_data_status.txt

# Verify IP was retrieved
if [ -z "$INSTANCE_PRIVATE_IP" ]; then
    echo "ERROR: Failed to retrieve instance private IP" >> /var/log/user_data_status.txt
    exit 1
fi

# Docker Installation
sudo apt-get update
sudo apt install docker.io -y
sudo usermod -aG docker $USER && newgrp docker
docker --version >> /var/log/user_data_status.txt

# Kind Installation 
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
kind version >> /var/log/user_data_status.txt

# Kubectl Installation
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl   
kubectl version --client >> /var/log/user_data_status.txt

# Helm Installation 
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh
helm version >> /var/log/user_data_status.txt

# Kind Cluster Config creation
# hostname | awk -F'ip-' '{print $2}'
mkdir -p /root/KindCluster
cat << EOF > /root/KindCluster/kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerAddress: "${INSTANCE_PRIVATE_IP}"
  apiServerPort: 33893
nodes:
  - role: control-plane
    image: kindest/node:v1.33.1
  - role: worker
    image: kindest/node:v1.33.1
  - role: worker
    image: kindest/node:v1.33.1
EOF

kind create cluster --name argocd-cluster --config /root/KindCluster/kind-config.yaml --wait 5m

#
export KUBECONFIG=/root/.kube/config
kind export kubeconfig --name argocd-cluster
echo 'export KUBECONFIG=/root/.kube/config' >> /root/.bashrc
echo "alias k='kubectl'" >> /root/.bashrc
source .bashrc

if kubectl get nodes &> /dev/null; then
    echo "Cluster is ready, nodes are accessible" >> /var/log/user_data_status.txt
else
    echo "Cluster not ready yet" >> /var/log/user_data_status.txt
fi

# Helm ArgoCD Setup
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
kubectl create namespace argocd


if helm install argocd argo/argo-cd -n argocd >> /var/log/user_data_status.txt 2>&1; then
    echo "Helm Installation for ArgoCD Successful." >> /var/log/user_data_status.txt    
    # Wait for secret to be created
    sleep 60
    ARGOCD_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -n argocd \
      -o jsonpath="{.data.password}" | base64 -d)    
    echo "${ARGOCD_PASSWORD}" > /root/initial_password.txt
    
else
    echo "Helm Installation for ArgoCD unsuccessful." >> /var/log/user_data_status.txt
fi


# ArgoCD CLI Installation
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

argocd version --client >> /var/log/user_data_status.txt


# Exporting port forward to connect ArgoCD
export HOME=/root
nohup kubectl port-forward service/argocd-server -n argocd 8080:443 --address=0.0.0.0 \
  > /var/log/argocd-portforward.log 2>&1 &

PF_PID=$!
echo $PF_PID > /var/run/argocd-portforward.pid
disown

echo "ArgoCD port-forward started with PID ${PF_PID}" >> /var/log/user_data_status.txt

sleep 5
if ps -p $PF_PID > /dev/null; then
    echo "Port-forward process is running" >> /var/log/user_data_status.txt
else
    echo "ERROR: Port-forward failed to start" >> /var/log/user_data_status.txt
fi