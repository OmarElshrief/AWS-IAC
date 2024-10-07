output "s3_bucket_name" {
  value       = aws_s3_bucket.vois-s3.bucket
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.vois-s3.arn
}
