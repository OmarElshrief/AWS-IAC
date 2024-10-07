output "ec2_instance_id" {
  value       = aws_instance.web.id
}

#  EC2  Public IP
output "ec2_public_ip" {
  value       = aws_instance.web.public_ip
}
