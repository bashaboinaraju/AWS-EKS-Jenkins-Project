variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "ebs_role_arn" {
  description = "EBS CSI IAM Role ARN"
  type        = string
}

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}