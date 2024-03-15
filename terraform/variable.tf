variable "public_subnets" {
  type = list(any)
}
variable "private_subnets" {
  type = list(any)
}
variable "instance_types" {
  type = list(any)
}
variable "vpc_cidr_block" {}
variable "vpc_name" {}
variable "environment" {}
variable "eks-clusterName" {}
variable "region" {}
