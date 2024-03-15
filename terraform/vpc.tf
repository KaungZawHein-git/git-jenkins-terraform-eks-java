module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs                  = data.aws_availability_zones.azs.zone_ids
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Automation                                     = "terraform"
    "kubernetes.io/cluster/${var.eks-clusterName}" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks-clusterName}" = "shared"
    "kubernetes.io/role/elb"                       = 1
    Automation                                     = "terraform"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks-clusterName}" = "shared"
    "kubernetes.io/role/internal-elb"              = 1
    Automation                                     = "terraform"
  }
}