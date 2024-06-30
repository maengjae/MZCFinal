output "cloudfront-distribution-id" {
  value = try(aws_cloudfront_distribution.cdn-web-elb-distribution.id)
}

output "cloudfront-distribution-arn" {
  value = try(aws_cloudfront_distribution.cdn-web-elb-distribution.arn)
}