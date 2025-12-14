
resource "aws_default_vpc" "default" {
  
}


resource "aws_security_group" "Ansible_Dev_SG" {
  name        = "Ansible_Dev_SG"
  description = "Allow Traffic for Ansible"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "Ansible Setup"
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      =  "SSH"
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      =  "HTTP"
  }
  ingress {
    from_port       = 8
    to_port         = -1
    protocol        = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    description     = "ICMP"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    description      =  "All Open access"
  }
}