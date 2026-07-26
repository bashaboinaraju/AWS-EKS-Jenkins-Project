############################################
# VPC
############################################

resource "aws_vpc" "this" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = "eks-vpc"
    }
  )
}

############################################
# INTERNET GATEWAY
############################################

resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.common_tags,
    {
      Name = "eks-igw"
    }
  )
}

############################################
# PUBLIC SUBNET 1
############################################

resource "aws_subnet" "public1" {

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_1
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "public-subnet-1"

      "kubernetes.io/role/elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

############################################
# PUBLIC SUBNET 2
############################################

resource "aws_subnet" "public2" {

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_2
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = "public-subnet-2"

      "kubernetes.io/role/elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

############################################
# PRIVATE SUBNET 1
############################################

resource "aws_subnet" "private1" {

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_1
  availability_zone = var.availability_zone_1

  tags = merge(
    var.common_tags,
    {
      Name = "private-subnet-1"

      "kubernetes.io/role/internal-elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

############################################
# PRIVATE SUBNET 2
############################################

resource "aws_subnet" "private2" {

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_2
  availability_zone = var.availability_zone_2

  tags = merge(
    var.common_tags,
    {
      Name = "private-subnet-2"

      "kubernetes.io/role/internal-elb" = "1"

      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

############################################
# ELASTIC IP
############################################

resource "aws_eip" "nat" {

  domain = "vpc"

  tags = merge(
    var.common_tags,
    {
      Name = "nat-eip"
    }
  )
}

############################################
# NAT GATEWAY
############################################

resource "aws_nat_gateway" "this" {

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public1.id

  depends_on = [
    aws_internet_gateway.this
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "nat-gateway"
    }
  )
}

############################################
# PUBLIC ROUTE TABLE
############################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.this.id

  }

  tags = merge(
    var.common_tags,
    {
      Name = "public-rt"
    }
  )
}

############################################
# PRIVATE ROUTE TABLE
############################################

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.this.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.this.id

  }

  tags = merge(
    var.common_tags,
    {
      Name = "private-rt"
    }
  )
}

############################################
# ASSOCIATIONS
############################################

resource "aws_route_table_association" "public1" {

  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {

  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {

  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {

  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}