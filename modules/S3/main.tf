resource "aws_s3_bucket" "vois-s3" {
  bucket = var.s3_bucket_name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = var.s3_bucket_name
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.vois-s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${aws_s3_bucket.vois-s3.bucket}/*"
        Principal = "*"
      }
    ]
  })
}
