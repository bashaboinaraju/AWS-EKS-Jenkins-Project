variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "m7i-flex.large"
}

variable "key_name" {
  type    = string
  default = ""
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
