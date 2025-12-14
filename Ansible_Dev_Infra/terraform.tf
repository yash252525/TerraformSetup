terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.26.0"
    }
  }
  backend "s3" {
    bucket = "yze25-s3-remote-backend"
    key = "Ansible_Dev_Infra_terraform.tfstate"
    dynamodb_table = "Remote_Operator_Table"
    region = "eu-north-1"
  }
}

