locals {
    region = "eu-north-1"
    name   = "yash-dev-eks-cluster"
    vpc_cidr = "10.0.0.0/16"
    azs             = ["eu-north-1a", "eu-north-1b","eu-north-1c" ]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    intra_subnets  = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
    environment = "dev"
}