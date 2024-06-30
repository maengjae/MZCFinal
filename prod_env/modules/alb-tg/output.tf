output "app-alb-name" {
  description = "DNS name of app alb"
  value       = try(aws_lb.app-elb.dns_name)
}

output "app-alb-zone" {
  description = "hosted zone of app alb"
  value       = try(aws_lb.app-elb.zone_id)
}