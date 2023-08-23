# Create a security group for the RDS instances
resource "aws_security_group" "rds_private_sg" {
  name_prefix = "rds_private_sg"
  vpc_id      = aws_vpc.terraform_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}