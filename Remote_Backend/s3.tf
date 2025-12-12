resource "aws_s3_bucket" "example" {
  bucket = "yze25-s3-remote-backend"

  tags = {
    Name        = "Remote Backend"
  }
}