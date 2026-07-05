module "test" {
  source            = "./config"
  ec2_instance_type = "t3.medium"
  root_block_size   = 10

}