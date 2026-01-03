#!/bin/bash
set -x
exec > >(tee /var/log/user_data.log) 2>&1


# Docker Installation
yum install -y docker
sudo usermod -aG docker root && newgrp docker
sudo systemctl start docker
sudo systemctl enable docker
docker --version >> /var/log/user_data_status.txt

# Docker Compose Installation
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 \
  -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
docker compsoe version >> /var/log/user_data_status.txt




# GIT Installation
yum install -y git