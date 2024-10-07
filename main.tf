module "Network" {
  source = "./modules/Network"
  
  vpc_cidr_block         = "10.0.0.0/16"
  vpc_name               = "Vois"
  
  public_subnet_cidr     = "10.0.1.0/24"
  public_subnet_name     = "public-subnet"
  public_az              = "us-east-1a"
  public_route_table_name = "public-RT"

  private_subnet_cidr    = "10.0.2.0/24"
  private_subnet_name    = "private-subnet"
  private_az             = "us-east-1a"
  private_route_table_name = "private-RT"
}


module "SGroups" {
  source  = "./modules/SGroups"
  
  vpc_id  = module.Network.vpc_id 
  ec2_sg_name = "ec2-sg"
  rds_sg_name = "rds-sg"
}

module "Compute" {
  source = "./modules/Compute"
  
  ami_id             = "ami-0c55b159cbfafe1f0"
  instance_type      = "t2.micro"
  subnet_id          = module.Network.public_subnet_id  
  security_group_id  = module.SGroups.ec2_security_group_id 
  ec2_instance_name  = "my-ec2-instance"
  ec2_iam_role_name  = "ec2-s3-role"
  ec2_s3_policy_name = "ec2-s3-read-policy"
  s3_bucket_name     = "VoisWeb-Bucket"
}

module "Database" {
  source = "./modules/Database"
  
  private_subnet_ids       = [module.Network.private_subnet_id]
  rds_subnet_group_name    = "my-rds-subnet-group"
  rds_instance_name        = "my-postgres-instance"
  rds_instance_class       = "db.t3.micro" 
  allocated_storage        = 20
  db_username              = "admin"
  db_password              = "963258741"  # Should be passed in AWS Secrets Manager
  rds_security_group_id    = module.SGroups.rds_security_group_id  
  backup_retention_period  = 7
  monitoring_interval      = 60
}

module "S3" {
  source = "./modules/S3"

  s3_bucket_name = "VoisWeb-Bucket"
  allow_public_read = true 
}



module "Lambda" {
  source = "./modules/Lambda"

  lambda_function_name   = "lambda-REQ"
  lambda_runtime         = "nodejs"  
  lambda_zip_path        = ""  # Path to the Lambda code zip file
  lambda_iam_role_name   = "lambda-rds-role"
  lambda_rds_policy_name = "lambda-rds-policy"
  
  private_subnet_ids     = [module.Network.private_subnet_id]
  lambda_security_group_id = module.SGroups.rds_security_group_id 

  rds_endpoint           = module.Database.rds_endpoint
  db_username            = "admin"
  db_password            = "963258741"
  db_name                = "voisDB"
}


# Call the Route 53 module
module "R53" {
  source         = "./modules/R53"
  domain_name    = "vois.com" 
  subdomain_name = "www"
  record_ttl     = 300
  record_value   = module.API.api_gateway_url
}





module "API" {
  source             = "./modules/API"
  api_name           = "web-api"
  api_description    = "API Gateway for Lambda interacting with RDS"
  api_stage          = "dev"
  endpoint_path      = "rds"  
  lambda_arn         = module.Lambda.lambda_function_arn
  lambda_function_name = "lambda-REQ"
}
