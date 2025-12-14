module "eks" {

    source  = "terraform-aws-modules/eks/aws"

    version = "~> 21.0"

    # Cluster Infromation (Control Plane)
    name = local.name
    kubernetes_version = "1.33"
    endpoint_public_access = true
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
    control_plane_subnet_ids = module.vpc.intra_subnets

    # Control Plane Network Configuration 
    addons = {
            coredns = {}
            kube-proxy             = {}
            vpc-cni                = {
            before_compute = true
            }
    }

    # Node Group Management
    # eks_managed_node_group_defaults = {
    #     instance_types = ["t3.medium"]
    #     attach_cluster_primary_security_group = true
    # }

    eks_managed_node_groups = {
        yash-cluster-ng-eks = {

        #   ami_type       = "AL2023_x86_64_STANDARD"
        instance_types = ["t3.medium"]
        attach_cluster_primary_security_group = true
        min_size     = 1 
        max_size     = 2
        desired_size = 1

        capacity_type = "SPOT"
        }
    }

    tags = {
        Environment = local.environment
        Terraform = "True"
    }

}