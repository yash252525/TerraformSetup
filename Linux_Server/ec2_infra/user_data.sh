#!/bin/bash
set -x
exec > >(tee /var/log/user_data.log) 2>&1


# Swap creation for server on t3.micro
sudo dd if=/dev/zero of=/swapfile bs=1M count=5120
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
free -h
swapon --show  >> /var/log/user_data_status.txt
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10
echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf
sudo sysctl -p /etc/sysctl.d/99-swappiness.conf

sleep 40

# Docker Installation
sudo yum update -y
sudo yum install -y docker
#sudo usermod -aG docker root && newgrp docker
sudo systemctl start docker
sudo systemctl enable docker
docker --version >> /var/log/user_data_status.txt

# Docker Compose Installation
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 \
  -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
docker compose version >> /var/log/user_data_status.txt




# GIT Installation
yum install -y git