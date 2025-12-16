resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_sg_test" {
  name        = "${var.project_name}-Terraform-SecurityGroup"
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
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      =  "ArgoCD"
  }

  ingress {
    from_port        = 8081
    to_port          = 8090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      =  "ArgoCD Application Deployments Port Forwarding"
  }
  
  ingress {
  from_port   = 33893
  to_port     = 33893
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Only allow from my instances --> changed for now
  description = "Kind Kubernetes API Server"
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
  count = var.num_servers # meta argument
  # for_each = tomap ({
  #   test_workloads = "t3.micro"
  #   prod_workloads = "t3.medium"
  # })
  depends_on = [ aws_security_group.my_sg_test ]
  
  security_groups = [aws_security_group.my_sg_test.name]
  instance_type = var.ec2_instance_type # in case of for_each -> each.value  
  ami = var.ec2_ami_id

  user_data = file("${path.module}/user_data.sh")
 
  root_block_device {
    volume_size = var.ec2_server_root_block_size
    volume_type = "gp3"
  }
  tags = {
    Name = "${var.server_name}-${ count.index +1 }" # in case of for_each -> Name = each.key
  }
}

