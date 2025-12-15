module "ec2" {
    source = "./ec2_infra"
    project_name = "YashGitlab"
    ec2_ami_id = "ami-0b46816ffa1234887"
    env = "dev"
    ec2_server_root_block_size = 10
    ec2_instance_type = "t3.micro"
    num_servers = 1
    server_name = "AWS-TF-SVR"
}