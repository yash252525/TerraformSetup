#!/bin/bash

sudo yum update
sudo yum install -y ansible

# Ansible User configuration
useradd -m -s /bin/bash ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/90-ansible
chmod 440 /etc/sudoers.d/90-ansible


mkdir -p /home/ansible/Ansible
chown -R ansible:ansible /home/ansible/Ansible

cat <<"EOF" >/home/ansible/Ansible/ansible.cfg
[defaults]
inventory = ./inventory
remote_user = ansible
log_path = /var/log/ansible.log

[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = false
EOF

cat <<"EOF" >/home/ansible/Ansible/inventory
[dev]
DEV-WORKER-1
DEV-WORKER-2
EOF