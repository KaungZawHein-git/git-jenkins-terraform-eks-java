public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
vpc_cidr_block  = "10.0.0.0/16"
vpc_name        = "EKS-VPC"
environment     = "Terraform-Dev"
eks-clusterName = "eks-cluster"
instance_types  = ["t2.small"]
region          = "us-east-2"
