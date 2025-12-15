variable ec2_instance_type {
    description = "Enter Tier" 
    type = string
}

variable ec2_server_root_block_size {
    description = "Enter root volume size (10 GB Default for Prod)"
    type = number
}

variable ec2_ami_id {
    description = "EC2 AMI ID"
    type = string
}

variable env {
  description = "Enter project Environment"
  type = string
}

variable num_servers {
    description = "Define number of servers"
    type = number
}

variable server_name {
    description = "Define server name"
    type = string
}

variable project_name {
    description = "Enter name of the project resource"
    type = string
}