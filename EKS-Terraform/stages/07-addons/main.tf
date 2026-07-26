terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "addons" {
  source = "../../modules/addons"

  cluster_name = var.cluster_name
  ebs_role_arn = var.ebs_role_arn
  common_tags = var.common_tags
}
