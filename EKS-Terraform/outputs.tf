output "cluster_name" {

  value = var.cluster_name

}

output "environment" {

  value = var.environment

}

output "project" {

  value = var.project_name

}###################################################
# VPC
###################################################

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

###################################################
# EKS
###################################################

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_version" {
  value = module.eks.cluster_version
}

output "oidc_provider" {
  value = module.eks.oidc_issuer
}

###################################################
# NODEGROUP
###################################################

output "nodegroup_name" {
  value = module.nodegroup.nodegroup_name
}

###################################################
# RDS
###################################################

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "database_name" {
  value = module.rds.db_name
}

###################################################
# JENKINS
###################################################

output "jenkins_public_ip" {
  value = module.bastion.public_ip
}

output "jenkins_private_ip" {
  value = module.bastion.private_ip
}