terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "security_group" {
  source = "../../modules/security-group"

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  common_tags = var.common_tags
}

output "bastion_sg_id" {
  value = module.security_group.bastion_sg
}

output "eks_cluster_sg_id" {
  value = module.security_group.eks_cluster_sg
}

output "worker_node_sg_id" {
  value = module.security_group.worker_node_sg
}

output "rds_sg_id" {
  value = module.security_group.rds_sg
}
