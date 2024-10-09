# Create a Route 53 hosted zone
resource "aws_route53_zone" "vois-zone" {
  name = var.domain_name

  tags = {
    Name = var.domain_name
  }
}

# Create a record
resource "aws_route53_record" "vois-record" {
  zone_id = aws_route53_zone.vois-zone.zone_id
  name    = var.subdomain_name
  type    = "CNAME"
  ttl     = var.record_ttl
  records = [var.record_value]
}
