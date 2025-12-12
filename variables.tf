variable ec2_instance_type {
    default = "t3.micro"
    type = string
}

variable ec2_default_root_block_size {
    default = 8
    type = number
}

variable ec2_ami_id {
    default = "ami-0b46816ffa1234887"
    type = string
}

variable "env" {
  default = "prod"
  type = string
}