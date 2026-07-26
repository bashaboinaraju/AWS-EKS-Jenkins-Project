resource "aws_ecr_repository" "backend" {
  name                 = "shopping-site-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "shopping-site-backend"
    Environment = "dev"
    Project     = "shopping-site"
  }
}

resource "aws_ecr_repository" "frontend" {
  name                 = "shopping-site-main"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "shopping-site-main"
    Environment = "dev"
    Project     = "shopping-site"
  }
}
