terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr         = var.vpc_cidr
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2

  common_tags = var.common_tags
  cluster_name = var.cluster_name

  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
