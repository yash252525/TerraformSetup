resource "aws_s3_bucket" "example" {
  bucket = "yash25-s3-remote-backend-ap-pun-region"

  tags = {
    Name        = "Remote Backend"
  }
}