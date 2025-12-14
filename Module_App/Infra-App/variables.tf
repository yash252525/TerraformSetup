variable "env" {
    description = "This is the environment for infra"
    type = string
}

variable "instance_count" {
    description = "Number of instances to create"
    type = number
}

variable "ec2_instance_type" {
    description = "Enter the instance type"
    type = string
}

variable ec2_ami_id {
    default = "ami-0b46816ffa1234887" # Keeping default Amazon Linux 
    type = string
}


variable hash_key {
    default = "Enter the hash key"
    type = string
}