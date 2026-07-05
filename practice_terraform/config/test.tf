
resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "yze1-test-sg" {
  name = "yze1-test-sg"
  description = "for practice purpose"
  vpc_id = aws_default_vpc.default.id
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

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"  #All
    cidr_blocks      = ["0.0.0.0/0"]
    description      =  "All Open access"
    
  }
}


resource "aws_instance" "yash-test-ec2" {
  ami           =  data.aws_ami.latest_amazon_linux.id #"resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = var.ec2_instance_type
  security_groups = [aws_security_group.yze1-test-sg.name]
  depends_on = [ aws_security_group.yze1-test-sg ]
  root_block_device {
    volume_size = var.root_block_size
    volume_type = "gp3"
  }
  tags = {
    Name = "test_prod_yze1"
  }
}