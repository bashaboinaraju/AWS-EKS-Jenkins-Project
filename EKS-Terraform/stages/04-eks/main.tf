terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "../../modules/iam"
  common_tags = var.common_tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  cluster_role_arn = module.iam.cluster_role_arn
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  eks_cluster_security_group = data.terraform_remote_state.security.outputs.eks_cluster_sg_id
  common_tags = var.common_tags
}

module "nodegroup" {
  source = "../../modules/nodegroup"

  cluster_name = module.eks.cluster_name
  cluster_version = var.cluster_version
  node_role_arn = module.iam.worker_role_arn
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  worker_security_group_id = data.terraform_remote_state.security.outputs.worker_node_sg_id
  instance_type = var.node_instance_type
  ami_id = var.node_ami_id
  desired_size = var.desired_size
  min_size = var.min_size
  max_size = var.max_size
  common_tags = var.common_tags

  depends_on = [module.eks]
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "node_group_name" {
  value = module.nodegroup.node_group_name
}
