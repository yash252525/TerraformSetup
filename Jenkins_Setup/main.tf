module "ec2" {
    source = "./jenkins_infra_setup"
    project_name = "YZE2_JK_TF"
    ec2_ami_id = "ami-0fa91bc90632c73c9"
    env = "dev"
    ec2_server_root_block_size = 15
    ec2_instance_type = "t3.micro"
    num_servers = 1
    server_name = "AWS-TF-JKSVR"
}