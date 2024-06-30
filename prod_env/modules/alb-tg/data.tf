data "aws_subnets" "app-elb-subnets" {
  filter {
    name   = "tag:Name"
    values = [for i in var.app-elb-subnets : "${var.public-subnet-name}${i}"]
  }
}

data "aws_security_group" "app-alb-sg" {
  filter {
    name   = "tag:Name"
    values = [var.app-alb-sg-name]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc-name]
  }
}

data "aws_acm_certificate" "cert" {
  domain = "*.${var.domain-name}"
}