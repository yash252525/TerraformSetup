variable ec2_instance_type {
    default = "t3.micro"
    type = string
}

variable ec2_default_root_block_size {
    default = 8
    type = number
}

variable ec2_ami_id {
    default = "ami-0fa91bc90632c73c9"
    type = string
}

variable "env" {
  default = "prod"
  type = string
}

variable "num_servers" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "server_name" {
  description = "Server name prefix"
  type        = string
  default     = "AWS-TF-JKSVR"
}

variable "ec2_server_root_block_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 10
}

variable "project_name" {
  description = "Project name to use in resource tags"
  type        = string
  default     = "MyProject-"
}