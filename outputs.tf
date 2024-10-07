# Network module
output "vpc_id" {
  value = module.Network.vpc_id
}

output "public_subnet_id" {
  value = module.Network.public_subnet_id
}

output "private_subnet_id" {
  value = module.Network.private_subnet_id
}
#**********************************************

# security group IDs
output "ec2_security_group_id" {
  value = module.SGroups.ec2_security_group_id
}

output "rds_security_group_id" {
  value = module.SGroups.rds_security_group_id
}
#**********************************************


# Compute module
output "ec2_instance_id" {
  value = module.Compute.ec2_instance_id
}

output "ec2_public_ip" {
  value = module.Compute.ec2_public_ip
}
#*****************************************


# Database module
output "rds_endpoint" {
  value = module.Database.rds_endpoint
}
#*****************************************



# S3 module
output "s3_bucket_name" {
  value = module.S3.s3_bucket_name
}

output "s3_bucket_arn" {
  value = module.S3.s3_bucket_arn
}
#*****************************************


# Lambda module
output "lambda_function_arn" {
  value = module.Lambda.lambda_function_arn
}
#*****************************************



# R53 module
output "dns_name" {
  value = module.R53.dns_name
}
#*****************************************

# API module
output "api_gateway_url" {
  value = module.API.api_gateway_url
}