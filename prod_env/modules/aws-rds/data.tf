data "aws_security_group" "db-sg" {
  filter {
    name   = "tag:Name"
    values = [var.db-sg-name]
  }
}

data "aws_db_subnet_group" "db-subnet-group" {
  name = var.db-subnet-group-name
}
