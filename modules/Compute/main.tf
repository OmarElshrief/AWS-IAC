# IAM Role for EC2 instance to access S3
resource "aws_iam_role" "ec2_iam_role" {
  name = var.ec2_iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = var.ec2_iam_role_name
  }
}

resource "aws_iam_policy" "ec2_s3_read_policy" {
  name        = var.ec2_s3_policy_name
  description = "Policy that allows EC2 to read from an S3 bucket"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*" 
      }
    ]
  })

  tags = {
    Name = var.ec2_s3_policy_name
  }
}

resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  role       = aws_iam_role.ec2_iam_role.name
  policy_arn = aws_iam_policy.ec2_s3_read_policy.arn
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = var.ec2_instance_name
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.ec2_iam_role_name}_profile"
  role = aws_iam_role.ec2_iam_role.name
}
