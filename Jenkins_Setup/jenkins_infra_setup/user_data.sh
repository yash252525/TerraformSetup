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

# JDK Installation
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y
java -version >> /var/log/user_data_status.txt

# Jenkins (Long Term Support Release) Installation
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
jenkins --version >> /var/log/user_data_status.txt
sudo systemctl enable jenkins
sleep 30
sudo cat /var/lib/jenkins/secrets/initialAdminPassword >> /root/InitialPassword.txt

