variable "api_name" {
  type        = string
}

variable "api_description" {
  type        = string
}

variable "api_stage" {
  type        = string
  default     = "dev"
}

# Lambda Integration
variable "endpoint_path" {
  type        = string
  default     = "rds"
}

variable "lambda_arn" {
  type        = string
}

variable "lambda_function_name" {
  type        = string
}
