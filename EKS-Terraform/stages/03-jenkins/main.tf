terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "bastion" {
  source = "../../modules/bastion"

  ami_id            = "ami-004f790b835b26145"
  instance_type     = var.instance_type
  public_subnet_id  = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  security_group_id = data.terraform_remote_state.security.outputs.bastion_sg_id
  key_name          = var.key_name
  common_tags       = var.common_tags
}

output "jenkins_public_ip" {
  value = module.bastion.public_ip
}
