terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "rds" {
  source = "../../modules/rds"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  rds_security_group_id = data.terraform_remote_state.security.outputs.rds_sg_id
  common_tags = var.common_tags
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}
