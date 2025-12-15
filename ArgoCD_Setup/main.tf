module "ec2" {
    source = "./ec2_infra"
    project_name = "YashArgoCD"
    ec2_ami_id = "ami-0fa91bc90632c73c9"
    env = "Prod"
    ec2_server_root_block_size = 20
    ec2_instance_type = "t3.medium"
    num_servers = 1
    server_name = "AWS-TF-ARGCD"
}