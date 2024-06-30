# resource "aws_security_group" "web-alb-sg" {

#   vpc_id      = data.aws_vpc.vpc.id
#   description = "web-alb sg"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = var.web-alb-sg-name
#     # owner      = "mjy"
#     # createDate = formatdate("YYYY MM DD", timestamp())
#   }

#   depends_on = [data.aws_vpc.vpc]
# }


# resource "aws_security_group" "web-sg" {

#   vpc_id      = data.aws_vpc.vpc.id
#   description = "web-container sg"

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port       = 3000
#     to_port         = 3000
#     protocol        = "tcp"
#     security_groups = [aws_security_group.web-alb-sg.id]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = var.web-sg-name
#     # owner      = "mjy"
#     # createDate = formatdate("YYYY MM DD", timestamp())
#   }

#   depends_on = [aws_security_group.web-alb-sg]
# }

resource "aws_security_group" "app-alb-sg" {

  vpc_id      = data.aws_vpc.vpc.id
  description = "app-alb sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.app-alb-sg-name
    # owner      = "mjy"
    # createDate = formatdate("YYYY MM DD", timestamp())
  }
}


resource "aws_security_group" "app-sg" {

  vpc_id      = data.aws_vpc.vpc.id
  description = "app-container sg"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.app-alb-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.app-sg-name
    # owner      = "mjy"
    # createDate = formatdate("YYYY MM DD", timestamp())
  }

  depends_on = [aws_security_group.app-alb-sg]
}


# Creating Security Group for RDS Instances Tier With  only access to App-Tier ALB
resource "aws_security_group" "database-sg" {
  vpc_id      = data.aws_vpc.vpc.id
  description = "Protocol Type MySQL/Aurora"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.db-sg-name
    # owner      = "mjy"
    # createDate = formatdate("YYYY MM DD", timestamp())
  }

  depends_on = [aws_security_group.app-sg]
}