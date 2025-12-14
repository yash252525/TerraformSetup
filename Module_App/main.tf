# Dev Infra
module "dev-infra" {
    source = "./Infra-App"
    env = "dev"
    instance_count = 1
    ec2_instance_type = "t3.micro"
    hash_key = "student_id_dev"
}

# Prod Infra
module "prod-infra" {
    source = "./Infra-App"
    env = "prod"
    instance_count = 2
    ec2_instance_type = "t3.micro"
    hash_key = "student_id"
}

# Staging Infra
module "stg-infra" {
    source = "./Infra-App"
    env = "stg"
    instance_count = 1
    ec2_instance_type = "t3.micro"
    hash_key = "student_id_staging"
}