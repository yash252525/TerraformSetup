
output "Master_Details" {
    value = {
        public_ip = aws_instance.Ansible_Master.public_ip
        private_ip = aws_instance.Ansible_Master.private_ip
        hostnames = aws_instance.Ansible_Master.tags
         root_volume_size = aws_instance.Ansible_Master.root_block_device[0].volume_size
    }   
}

output "Worker_Details" {
    value = {
        public_ip = aws_instance.Ansible_Worker[*].public_ip
        private_ip = aws_instance.Ansible_Worker[*].private_ip
        hostnames = aws_instance.Ansible_Worker[*].tags
        root_volume_size = aws_instance.Ansible_Worker[*].root_block_device[0].volume_size
    }   
}