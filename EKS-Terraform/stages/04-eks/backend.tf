terraform {
  backend "s3" {
    bucket       = "shopping-site-terraform-state"
    key          = "stages/04-eks/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
