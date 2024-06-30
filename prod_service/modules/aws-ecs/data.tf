data "aws_security_group" "app-sg" {
  filter {
    name   = "tag:Name"
    values = [var.app-sg-name]
  }
}

data "aws_subnets" "app-subnets" {
  filter {
    name   = "tag:Name"
    values = [for i in var.app-subnets : "${var.private-subnet-name}${i}"]
  }
}

data "aws_lb_target_group" "app-tg" {
  tags = {
    Name = var.app-tg-name
  }
}

data "aws_iam_role" "task-execution" {
  name = var.task-execution-role-name
}
