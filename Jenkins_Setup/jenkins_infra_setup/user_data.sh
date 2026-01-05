#!/bin/bash
set -x
exec > >(tee /var/log/user_data.log) 2>&1


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

