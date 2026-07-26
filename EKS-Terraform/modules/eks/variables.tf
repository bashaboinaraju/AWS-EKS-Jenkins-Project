variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes Version"
  type        = string
}

variable "cluster_role_arn" {
  description = "EKS Cluster IAM Role ARN"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "eks_cluster_security_group" {
  description = "EKS Cluster Security Group"
  type        = string
}

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}