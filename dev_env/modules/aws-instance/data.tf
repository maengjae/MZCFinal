data "aws_security_group" "db-sg" {
  filter {
    name = "tag:Name"
    values = [var.db-sg-name]
  }
}

data "aws_subnet" "dev-db-subnet" {
  filter {
    name   = "tag:Name"
    values = ["${var.private-subnet-name}${var.subnet}"]
  }
}

data "aws_security_group" "app-sg" {
  filter {
    name   = "tag:Name"
    values = [var.app-sg-name]
  }
}

data "aws_subnet" "dev-app-subnet" {
  filter {
    name   = "tag:Name"
    values = ["${var.public-subnet-name}${var.subnet}"]
  }
}

data "aws_s3_bucket" "dev_static_bucket" {
  bucket = var.dev-static-bucket
}