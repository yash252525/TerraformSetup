module "ec2" {
    source = "./jenkins_infra_setup"
    project_name = "YZE2_JK_TF_"
    ec2_ami_id = "ami-0fa91bc90632c73c9"
    env = "dev"
    ec2_server_root_block_size_master = 15
    ec2_server_root_block_size_agent = 15
    ec2_instance_type = "t3.micro"
    master_servers = 1
    master_server_name = "AWS-TF-JKSVR"
    agent_servers = 1
    agent_server_name = "AWS-TF-JKAGT"
}