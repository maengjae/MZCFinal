variable "private-subnet-name" {}
variable "public-subnet-name" {}
# variable "web-elb-subnets" {
#   type = list(string)
# }
# variable "web-alb-name" {}
# variable "web-alb-sg-name" {}
# variable "web-tg-name" {}
# variable "web-listener-name" {}

variable "app-elb-subnets" {
  type = list(string)
}
variable "app-alb-sg-name" {}
variable "app-alb-name" {}
variable "app-tg-name" {}
variable "app-listener-name" {}
variable "vpc-name" {}
variable "domain-name" {}
variable "mjy-bucket" {}