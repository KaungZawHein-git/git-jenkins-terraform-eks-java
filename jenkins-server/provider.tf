provider "aws" {
  profile = "terraform-user"
  region  = var.region
}

terraform {
  backend "s3" {
    bucket = "terraform-statefile-backend-useast1"
    key    = "jenkins/terraform.tfstate.devopsacad"
    region = "us-east-1"
  }
}