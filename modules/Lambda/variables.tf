variable "lambda_function_name" {
  type        = string
}

variable "lambda_runtime" {
  type        = string
}

variable "lambda_zip_path" {
  description = "The path to the Lambda function code in zip format"
  type        = string
}

variable "lambda_iam_role_name" {
  type        = string
}

variable "lambda_rds_policy_name" {
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "lambda_security_group_id" {
  type        = string
}

variable "rds_endpoint" {
  description = "The endpoint of the RDS PostgreSQL instance"
  type        = string
}

variable "db_username" {
  type        = string
}

variable "db_password" {
  type        = string
  sensitive   = true
}

variable "db_name" {
  type        = string
}
