# IAM Role 
resource "aws_iam_role" "lambda_iam_role" {
  name = var.lambda_iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = var.lambda_iam_role_name
  }
}

resource "aws_iam_policy" "lambda_rds_policy" {
  name        = var.lambda_rds_policy_name
  description = "Policy that allows Lambda to interact with RDS and read Secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "rds:DescribeDBInstances",
          "rds:Connect"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_iam_role.name
  policy_arn = aws_iam_policy.lambda_rds_policy.arn
}

# Lambda Function
resource "aws_lambda_function" "RDS-Lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_iam_role.arn
  handler       = "index.handler"
  runtime       = var.lambda_runtime
  filename      = var.lambda_zip_path

  vpc_config {
    security_group_ids = [var.lambda_security_group_id]
    subnet_ids         = var.private_subnet_ids
  }

  environment {
    variables = {
      DB_HOST     = var.rds_endpoint
      DB_USER     = var.db_username
      DB_NAME     = var.db_name
      DB_PASSWORD = var.db_password
    }
  }

  tags = {
    Name = var.lambda_function_name
  }
}
