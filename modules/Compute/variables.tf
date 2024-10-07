# EC2 Instance Variables
variable "ami_id" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "subnet_id" {
  type        = string
}

variable "security_group_id" {
  type        = string
}

variable "ec2_instance_name" {
  type        = string
}

# IAM Role and Policy Variables
variable "ec2_iam_role_name" {
  type        = string
}

variable "ec2_s3_policy_name" {
  type        = string
}

variable "s3_bucket_name" {
  type        = string
}
