variable "aws_region" {
  type    = string
  default = "us-east-1"
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
