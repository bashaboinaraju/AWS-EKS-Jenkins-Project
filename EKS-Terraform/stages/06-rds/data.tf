data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket       = "shopping-site-terraform-state"
    key          = "stages/01-network/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

data "terraform_remote_state" "security" {
  backend = "s3"

  config = {
    bucket       = "shopping-site-terraform-state"
    key          = "stages/02-security/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
