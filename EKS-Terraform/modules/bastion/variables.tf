variable "ami_id" {
  description = "Amazon Linux AMI"
  type        = string
}

variable "instance_type" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}