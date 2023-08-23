# Create 2 public subnets in two availability zones
resource "aws_subnet" "public_subnet-1" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.PUBLIC_SUBNET_1_CIDR
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet-2" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.PUBLIC_SUBNET_2_CIDR
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}


# Create 2 private subnets in two availability zones
resource "aws_subnet" "private_subnet-1" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.PRIVATE_SUBNET_1_CIDR
  availability_zone = "us-east-1c"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.PRIVATE_SUBNET_2_CIDR
  availability_zone = "us-east-1d"

  tags = {
    Name = "private-subnet-2"
  }
}
