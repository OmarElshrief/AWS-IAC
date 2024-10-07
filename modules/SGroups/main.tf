# EC2 SG
resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg_name
  description = "Allow HTTP and SSH access for EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ec2_sg_name
  }
}

# RDS SG
resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = "Allow access to RDS from EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow PostgreSQL access from EC2"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]  # Allow EC2 SG access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_sg_name
  }
}
