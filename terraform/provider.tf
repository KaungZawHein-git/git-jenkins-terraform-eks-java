provider "aws" {
  region  = var.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

terraform {
  backend "s3" {
    bucket = "terraform-statefile-backend-useast1"
    key    = "devopsacad/terraform.tfstate.devopsacad"
    region = "us-east-1"
  }
}