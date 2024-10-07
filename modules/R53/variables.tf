variable "domain_name" {
  type        = string
}

variable "subdomain_name" {
  type        = string
}

variable "record_ttl" {
  description = "The time-to-live for the DNS record"
  type        = number
  default     = 300
}

variable "record_value" {
  type        = string
}
