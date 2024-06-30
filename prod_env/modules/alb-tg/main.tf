# Creating ALB for App Tier
resource "aws_lb" "app-elb" {
  name                       = var.app-alb-name
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = data.aws_subnets.app-elb-subnets.ids
  security_groups            = [data.aws_security_group.app-alb-sg.id]
  ip_address_type            = "ipv4"
  enable_deletion_protection = false
  access_logs {
    bucket = var.mjy-bucket
    enabled = true
  }

  tags = {
    Name       = var.app-alb-name
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}

# Creating Target Group for App-Tier 
resource "aws_lb_target_group" "app-tg" {

  name = "${var.app-tg-name}"
  health_check {
    enabled             = true
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  target_type = "ip"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.vpc.id

  tags = {
    Name       = "${var.app-tg-name}"
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }

  lifecycle {
    prevent_destroy = false
  }
  depends_on = [aws_lb.app-elb]
}


# Creating ALB listener with port 443 and attaching it to App-Tier Target Group
resource "aws_lb_listener" "app-alb-listener1" {
  load_balancer_arn = aws_lb.app-elb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
  
  depends_on = [aws_lb_target_group.app-tg]

  tags = {
    Name       = "${var.app-listener-name}1"
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}