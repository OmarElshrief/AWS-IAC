resource "aws_api_gateway_rest_api" "web-api" {
  name        = var.api_name
  description = var.api_description

  tags = {
    Name = var.api_name
  }
}

resource "aws_api_gateway_resource" "rds_resource" {
  rest_api_id = aws_api_gateway_rest_api.web-api.id
  parent_id   = aws_api_gateway_rest_api.web-api.root_resource_id
  path_part   = var.endpoint_path  
}

resource "aws_api_gateway_method" "rds_method" {
  rest_api_id   = aws_api_gateway_rest_api.web-api.id
  resource_id   = aws_api_gateway_resource.rds_resource.id
  http_method   = "GET"  
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.web-api.id
  resource_id = aws_api_gateway_resource.rds_resource.id
  http_method = aws_api_gateway_method.rds_method.http_method
  type        = "AWS_PROXY"
  integration_http_method = "GET"
  uri         = var.lambda_arn
}

resource "aws_api_gateway_deployment" "web-api" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.web-api.id
  stage_name  = var.api_stage
}

resource "aws_lambda_permission" "lambda_api_permission" {
  statement_id  = "AllowAPIGatewayInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.web-api.execution_arn}/*/${aws_api_gateway_method.rds_method.http_method}/${var.endpoint_path}"
}
