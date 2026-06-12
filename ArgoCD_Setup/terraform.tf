terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.25.0"
    }
  }

  backend "s3" {
  bucket = "yash25-s3-remote-backend-ap-pun-region"
  key = "terraform.tfstate"
  dynamodb_table = "Remote_Operator_Table_AP_South"
  region = "ap-south-1"
  }
}
