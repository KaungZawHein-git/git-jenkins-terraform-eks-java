variable "ingressports" {
  type    = list(number)
  default = [8080, 22]
}
variable "instance_type" {}
variable "environment" {}
variable "region" {}
variable "key_name" {}
