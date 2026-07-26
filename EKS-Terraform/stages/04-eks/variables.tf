variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "naresh"
}

variable "cluster_version" {
  type    = string
  default = "1.35"
}

variable "node_instance_type" {
  type    = string
  default = "m7i-flex.large"
}

variable "node_ami_id" {
  type    = string
  default = ""
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 2
}

variable "common_tags" {
  type = map(string)
  default = {
    Project     = "shopping-site"
    Environment = "dev"
    Owner       = "veeraops"
    ManagedBy   = "Terraform"
  }
}
