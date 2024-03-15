module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                   = var.eks-clusterName
  cluster_version                = "1.27"
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  eks_managed_node_groups = {
    node__group__1 = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = [var.instance_types[0]]
      capacity_type  = "SPOT"
    }
    node__group__2 = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = [var.instance_types[0]]
      capacity_type  = "SPOT"
    }
  }




  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}