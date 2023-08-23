#create NAT gateways for private subnet
resource "aws_nat_gateway" "private_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet-1.id
  tags = {
    Name = "private-nat-gateway"
  }
  depends_on = [aws_internet_gateway.terraform_igw]
}

# Create an EIP for NAT gateway
resource "aws_eip" "nat_gateway_eip" {
  vpc = true
  tags = {
    Name = "nat-gateway-eip"
  }
  depends_on = [aws_internet_gateway.terraform_igw]
}