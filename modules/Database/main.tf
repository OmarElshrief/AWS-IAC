resource "aws_db_subnet_group" "private" {
  name       = var.rds_subnet_group_name
  subnet_ids = var.private_subnet_ids
  
  tags = {
    Name = var.rds_subnet_group_name
  }
}

resource "aws_db_instance" "voisDB" {
  identifier             = var.rds_instance_name
  engine                 = "postgres"
  instance_class         = var.rds_instance_class
  allocated_storage      = var.allocated_storage
  username               = var.db_username
  password               = var.db_password
  port                   = 5432
  db_subnet_group_name   = aws_db_subnet_group.private.name
  vpc_security_group_ids = [var.rds_security_group_id]
  multi_az               = true
  publicly_accessible    = false 
  storage_encrypted      = true
  backup_retention_period = var.backup_retention_period
  monitoring_interval     = var.monitoring_interval

  tags = {
    Name = var.rds_instance_name
  }
}

resource "aws_db_parameter_group" "DB-parameters" {
  name        = var.rds_parameter_group_name
  family      = "postgres12"
  description = "Custom PostgreSQL parameter group"
  
  parameter {
    name  = "max_connections"
    value = "100"
  }

  tags = {
    Name = var.rds_parameter_group_name
  }
}
