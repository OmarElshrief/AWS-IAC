# RDS Endpoint
output "rds_endpoint" {
  value       = aws_db_instance.voisDB.endpoint
}

output "rds_instance_id" {
  value       = aws_db_instance.voisDB.id
}
