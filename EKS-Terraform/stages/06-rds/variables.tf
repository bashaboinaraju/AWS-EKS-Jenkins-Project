variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "db_name" {
  type    = string
  default = "mydb"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = "Admin12345!"
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
