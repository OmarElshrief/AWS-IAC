output "zone_id" {
  value       = aws_route53_zone.vois-zone.zone_id
}

output "dns_name" {
  value       = "${aws_route53_record.vois-record.name}.${aws_route53_zone.vois-zone.name}"
}
