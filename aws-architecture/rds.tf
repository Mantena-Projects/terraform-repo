# Create a DB subnet group for the RDS instances
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "private-db-subnet-group"
  subnet_ids  = [aws_subnet.private_subnet-1.id, aws_subnet.private_subnet-2.id]
  description = "Subnets available for the RDS DB Instance"
}


# Create the primary RDS instances in private subnet (active-passive)
resource "aws_db_instance" "rds_primary_instances" {
  identifier_prefix       = "mydb-rds-primary"
  engine                  = "mysql"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  backup_retention_period = 7
  username                = "username"
  password                = "password"
  vpc_security_group_ids  = [aws_security_group.rds_private_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot     = true
  tags = {
    Name = "RDS-private-instance"
  }
}
