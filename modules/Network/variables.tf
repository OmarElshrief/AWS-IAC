variable "vpc_cidr_block" {
  type        = string
}

variable "vpc_name" {
  type        = string
}

variable "public_subnet_cidr" {
  type        = string
}

variable "public_subnet_name" {
  type        = string
}

variable "public_az" {
  description = "Availability Zone for the public subnet"
  type        = string
}

variable "public_route_table_name" {
  type        = string
}

variable "private_subnet_cidr" {
  type        = string
}

variable "private_subnet_name" {
  type        = string
}

variable "private_az" {
  description = "Availability Zone for the private subnet"
  type        = string
}

variable "private_route_table_name" {
  type        = string
}
