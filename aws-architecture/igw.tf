# Create the Internet Gateways

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "demo_igw"
  }
}


