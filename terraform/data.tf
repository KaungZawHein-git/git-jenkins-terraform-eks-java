data "aws_availability_zones" "azs" {
  state                  = "available"
  all_availability_zones = true
}