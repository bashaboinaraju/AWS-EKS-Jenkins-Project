data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket       = "shopping-site-terraform-state"
    key          = "stages/04-eks/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
