resource "aws_s3_bucket" "remote_s3" {
  bucket = "${var.env}-infra-yze25-application-bucket"

  tags = {
    Name        = "${var.env}-infra-yze25-application-bucket"
    Environment = var.env 
  }
}