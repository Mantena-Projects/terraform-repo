# Create VPC
resource "aws_vpc" "terraform_vpc" {
  cidr_block       = var.VPC_CIDR
  instance_tenancy = "default"
  tags = {
    Name = "Demo_VPC"
  }
}

