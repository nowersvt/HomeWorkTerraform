resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [var.subnet1, var.subnet2]
}

resource "aws_db_instance" "rds" {
  allocated_storage      = var.allocated_storage
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.instance_class
  db_name                = var.name_db
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids
  availability_zone      = "eu-north-1a"
  skip_final_snapshot    = true
}