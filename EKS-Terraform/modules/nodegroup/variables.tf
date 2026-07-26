variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "worker_security_group_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type    = string
  default = ""
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "disk_size" {
  type    = number
  default = 30
}

variable "common_tags" {
  type = map(string)
}

variable "ssh_key_name" {
  type    = string
  default = ""
}