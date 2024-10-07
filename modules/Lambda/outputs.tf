output "lambda_function_arn" {
  value       = aws_lambda_function.RDS-Lambda.arn
}


output "lambda_iam_role_arn" {
  value       = aws_iam_role.lambda_iam_role.arn
}
