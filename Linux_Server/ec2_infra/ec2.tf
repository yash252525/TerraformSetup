# Add these data sources at top of ec2.tf
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id       = data.aws_vpc.default.id
  availability_zone = "ap-south-1a"  # Your AZ
}

resource "aws_security_group" "my_sg_test" {
  name        = "${var.env}-Terraform-SecurityGroup"
  description = "Default "
  vpc_id      = data.aws_vpc.default.id # interpolation

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

  ingress {
    from_port        = 8080
    to_port          = 8080
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
    Name = "${var.project_name}SecurityGroup"
  } 
}

# Instance Create
resource "aws_instance" "my_instance" {
  count = var.num_servers
  vpc_security_group_ids = [aws_security_group.my_sg_test.id]  
  subnet_id             = data.aws_subnet.default.id          
  instance_type         = var.ec2_instance_type
  ami                   = var.ec2_ami_id
  user_data             = file("${path.module}/user_data.sh")
  
  root_block_device {
    volume_size = var.env == "prod" ? 10 : var.ec2_server_root_block_size
    volume_type = "gp3"
  }
  tags = {
    Name = "${var.server_name}-${count.index + 1}"
  }
}

# Importing a resource from AWS
# We will use instance id to import the data

# resource "aws_instance" "manual_created_instance" {
#   ami = "unknown"
#   instance_type = "unknown"
# }