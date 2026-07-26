variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_subnet_1" {
  type    = string
  default = "10.0.3.0/24"
}

variable "private_subnet_2" {
  type    = string
  default = "10.0.4.0/24"
}

variable "cluster_name" {
  type    = string
  default = "naresh"
}

variable "availability_zone_1" {
  type    = string
  default = "us-east-1a"
}

variable "availability_zone_2" {
  type    = string
  default = "us-east-1b"
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
