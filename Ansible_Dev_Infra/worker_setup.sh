#!/bin.bash

# Ansible User configuration
useradd -m -s /bin/bash ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/90-ansible
chmod 440 /etc/sudoers.d/90-ansible


mkdir -p /home/ansible/Ansible
chown -R ansible:ansible /home/ansible/Ansible