variable "aws_region_eu_north_1" {
    default = "eu-north-1"
    type = string
}

variable "ami_id" {
  default = "ami-0b46816ffa1234887"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "root_volume_storage_worker" {
    default = 10
    type = number
}

variable "key_name" {
    default = "yash25key"
    type = string
}