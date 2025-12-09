# key pair

resource aws_key_pair ssh_key {
    key_name = "terraform_key_ec2"
    public_key = file ("C:\\Users\\yashz\\.ssh\\id_ed25519.pub")
}

# VPC, SG

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_sg_test" {
  name        = "TestSecurityGroup"
  description = "Default "
  vpc_id      = aws_default_vpc.default.id   # interpolation

  # ingress
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
  
  # egress
    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"  #All
    cidr_blocks      = ["0.0.0.0/0"]
    description      =  "All Open access"
    
  }

  tags = {
    Name = "Test SG"
  } 
}



# Instance Create
resource "aws_instance" "my_instance" {
  key_name = aws_key_pair.ssh_key.key_name
  security_groups = [aws_security_group.my_sg_test.name]
  instance_type = var.ec2_instance_type
  ami = var.ec2_ami_id

  # user data for web server installation
  user_data = file("C:\\Users\\yashz\\Desktop\\YashPractice\\Terraform\\install_httpd.sh")

  root_block_device {
    volume_size = var.ec2_root_block_size
    volume_type = "gp3"
  }
  tags = {
    env = "test"
  }
}