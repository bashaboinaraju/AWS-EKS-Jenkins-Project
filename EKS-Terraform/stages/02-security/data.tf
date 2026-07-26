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
