
# Create a route tables for the public subnets
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }
  tags = {
    Name = "public-subnet-route-table"
  }
}

# Create a route tables for the private subnets
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "private-subnet-route-table"
  }
}

#.........................................................................

# Associate public subnet-1 with public route tables
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.public_subnet_route_table.id
  depends_on     = [aws_internet_gateway.terraform_igw]
}

# Associate public subnet-2 with public route tables
resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet-2.id
  route_table_id = aws_route_table.public_subnet_route_table.id
  depends_on     = [aws_internet_gateway.terraform_igw]
}

# Associate private subnet-1 with private route tables
resource "aws_route_table_association" "private_subnet-1_association" {
  subnet_id      = aws_subnet.private_subnet-1.id
  route_table_id = aws_route_table.private_subnet_route_table.id
  depends_on     = [aws_internet_gateway.terraform_igw]
}

# Associate private subnet-1 with private route tables
resource "aws_route_table_association" "private_subnet-2_association" {
  subnet_id      = aws_subnet.private_subnet-2.id
  route_table_id = aws_route_table.private_subnet_route_table.id
  depends_on     = [aws_internet_gateway.terraform_igw]
}

