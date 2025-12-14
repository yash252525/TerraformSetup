# Define SG -> Done
# Key setup for SSH -> Done 
# EC2 Instance Creation

resource "aws_instance" "Ansible_Master" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  user_data = file("${path.module}/ansible_setup.sh")
  depends_on = [ aws_security_group.Ansible_Dev_SG ]
  security_groups = [ aws_security_group.Ansible_Dev_SG.name ]
    root_block_device {
        volume_size = 8
        volume_type = "gp3"
    }
  tags = {
    Name = "Ansible_Master"
    Role = "Control"
  }
}


resource "aws_instance" "Ansible_Worker" {
  count = 2
  ami                     = var.ami_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  
  user_data = file("${path.module}/worker_setup.sh")
  depends_on = [ aws_security_group.Ansible_Dev_SG ]
  security_groups = [ aws_security_group.Ansible_Dev_SG.name ]
    root_block_device {
        volume_size = var.root_volume_storage_worker
        volume_type = "gp3"
    }
  tags = {
    Name = "DEV-WORKER-${count.index + 1 }"
    Role = "Managed"
  }
}