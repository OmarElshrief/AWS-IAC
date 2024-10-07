output "api_gateway_url" {
  value       = "${aws_api_gateway_rest_api.web-api.execution_arn}/${var.api_stage}"
}

output "api_id" {
  value       = aws_api_gateway_rest_api.web-api.id
}
