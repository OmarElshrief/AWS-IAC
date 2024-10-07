# Subnet Group Variables
variable "private_subnet_ids" {
  type        = list(string)
}

variable "rds_subnet_group_name" {
  type        = string
}

# RDS Instance Variables
variable "rds_instance_name" {
  type        = string
}

variable "rds_instance_class" {
  type        = string
}

variable "allocated_storage" {
  type        = number
}

variable "db_username" {
  type        = string
}

variable "db_password" {
  type        = string
  sensitive   = true
}

variable "rds_security_group_id" {
  type        = string
}

variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
}

variable "monitoring_interval" {
  type        = number
  default     = 60
}

variable "rds_parameter_group_name" {
  type        = string
  default     = "custom-postgres"
}
