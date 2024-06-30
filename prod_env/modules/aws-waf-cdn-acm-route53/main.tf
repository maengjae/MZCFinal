terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# #ACM

# resource "aws_acm_certificate" "cert" {
#   domain_name               = var.domain-name
#   validation_method         = "DNS"
#   subject_alternative_names = [var.domain-name, "*.${var.domain-name}"]

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # ACM certificate validation resource using the certificate ARN and a list of validation record FQDNs.
# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn         = aws_acm_certificate.cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
# }


# # route53

# # AWS Route53 record resource for certificate validation with dynamic for_each loop and properties for name, records, type, zone_id, and ttl.
# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.zone.zone_id
#   ttl             = 60
# }


# AWS Route53 record resource for the "www" subdomain. The record uses an "A" type record and an alias to the AWS CloudFront distribution with the specified domain name and hosted zone ID. The target health evaluation is set to false.
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.id
  name    = "www.${var.domain-name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn-web-elb-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cdn-web-elb-distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

# AWS Route53 record resource for the apex domain (root domain) with an "A" type record. The record uses an alias to the AWS CloudFront distribution with the specified domain name and hosted zone ID. The target health evaluation is set to false.
resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = var.domain-name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn-web-elb-distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cdn-web-elb-distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

# AWS Route53 record resource for the "back" subdomain with an A type record, using alias to ALB in Ohio region.
resource "aws_route53_record" "back" {
  zone_id = data.aws_route53_zone.zone.id
  name    = "back.${var.domain-name}"
  type    = "A"

  alias {
    name                   = var.app-alb-name # DNS name of your ALB
    zone_id                = var.app-alb-zone # Hosted zone ID of your ALB
    evaluate_target_health = true             # Set to true to evaluate the health of the ALB target
  }
}

#WAF

# We have created one rule where any user if try to access our Application through TOR browser or any VPN, then the user will not be able to access the Application
resource "aws_wafv2_web_acl" "web_acl" {
  name  = var.web_acl_name #required
  scope = "CLOUDFRONT"     #required
  default_action {         #required
    allow {}
  }

  rule {
    name     = "AWSManagedRulesAnonymousIpList" #free
    priority = 2

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "BlockIPRuleMetrics"
      sampled_requests_enabled   = false
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }
      }
    }
  }

  rule {
    name     = "AWSManagedRulesSQLiRuleSet" #free
    priority = 1

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "BlockIPRuleMetrics"
      sampled_requests_enabled   = false
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }
      }
    }
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet" #free
    priority = 0

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "BlockIPRuleMetrics"
      sampled_requests_enabled   = false
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }
      }
    }
  }


  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "BlockIPRuleMetrics"
    sampled_requests_enabled   = false
  }
}



#CDN

resource "aws_cloudfront_cache_policy" "cdn_cache_policy" {
  name        = var.cache_policy_name
  min_ttl     = 1
  max_ttl     = 31536000
  default_ttl = 86400
  comment     = "mjy-cache-policy"
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }

  depends_on = [aws_wafv2_web_acl.web_acl]
}

resource "aws_cloudfront_origin_access_control" "OAC" {
  name = "mjy-OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"

  depends_on = [ aws_cloudfront_cache_policy.cdn_cache_policy ]
}

resource "aws_cloudfront_distribution" "cdn-web-elb-distribution" {
  origin { #required
    domain_name = var.static-bucket-domain    #check if custom origin config works. if not go back
    origin_id   = var.origin-id
    origin_access_control_id = aws_cloudfront_origin_access_control.OAC.id
  }

  aliases             = [var.domain-name, "www.${var.domain-name}"]
  enabled             = true #required
  is_ipv6_enabled     = false
  comment             = "CDN ALB Distribution"
  price_class         = "PriceClass_100" #least expensive class
  default_root_object = "index.html"

  default_cache_behavior { #required
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "POST", "DELETE", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.target-origin-id
    cache_policy_id  = aws_cloudfront_cache_policy.cdn_cache_policy.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions { #required
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  web_acl_id = aws_wafv2_web_acl.web_acl.arn

  logging_config {
    include_cookies = true
    bucket = var.bucket-domain-name
    prefix = "CloudfrontLogs/"
  }

  tags = {
    Name       = var.cdn-name
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }

  depends_on = [aws_cloudfront_origin_access_control.OAC]
}
