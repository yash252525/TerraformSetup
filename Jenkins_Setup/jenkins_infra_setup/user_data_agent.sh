#!/bin/bash

set -x
exec > >(tee /var/log/user_data.log) 2>&1

# Swap creation for server on t3.micro
sudo dd if=/dev/zero of=/swapfile bs=1M count=5120
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
free -h >> /var/log/user_data_status.txt
swapon --show  >> /var/log/user_data_status.txt
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10
echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf
sudo sysctl -p /etc/sysctl.d/99-swappiness.conf



# Install Java on Agent Nodes
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y 
java -version   >> /var/log/user_data_status.txt

# Installing Docker / Docker Compose
sudo apt-get install docker.io -y   >> /var/log/user_data_status.txt
sudo usermod -aG docker ubuntu && newgrp docker
sudo apt-get install docker-compose-v2 -y   >> /var/log/user_data_status.txt