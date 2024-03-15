output "clusterName" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "region" {
  value = var.region
}

output "aws_availability_zone" {
  value = data.aws_availability_zones.azs.names
}