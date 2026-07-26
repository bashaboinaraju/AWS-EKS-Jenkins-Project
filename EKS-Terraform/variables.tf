variable "aws_region" {

  type = string

  default = "us-east-1"

}

variable "environment" {

  type = string

  default = "dev"

}

variable "project_name" {

  type = string

  default = "shopping-site"

}

variable "owner" {

  type = string

  default = "veeraops"

}

variable "cluster_name" {

  type = string

  default = "naresh"

}

variable "cluster_version" {

  type = string

  default = "1.35"

}

variable "vpc_cidr" {

  default = "10.0.0.0/16"

}

variable "public_subnet_1" {

  default = "10.0.1.0/24"

}

variable "public_subnet_2" {

  default = "10.0.2.0/24"

}

variable "private_subnet_1" {

  default = "10.0.3.0/24"

}

variable "private_subnet_2" {

  default = "10.0.4.0/24"

}

variable "node_instance_type" {

  default = "m7i-flex.large"

}

variable "desired_size" {

  default = 4

}

variable "max_size" {

  default = 6

}

variable "min_size" {

  default = 1

}

variable "db_username" {

  default = "admin"

}

variable "db_password" {

  sensitive = true

}

variable "db_name" {

  default = "mydb"

}

variable "jenkins_instance_type" {

  default = "m7i-flex.large"

}
variable "key_name" {
  type = string
}