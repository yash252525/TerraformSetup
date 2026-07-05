variable ec2_instance_type {
  default = "t3.micro"
  type = string
}

variable root_block_size {
  default = 15
  type    = number
}