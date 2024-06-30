# instance
variable "db-instance-ami" {}
variable "app-instance-ami" {}
variable "instance-type" {}
variable "key-pair-name" {}
variable "ec2-profile-name" {}
variable "domain-name" {}

# data
variable "db-sg-name" {}
variable "private-subnet-name" {}
variable "subnet" {}
variable "app-sg-name" {}
variable "public-subnet-name" {}
variable "dev-static-bucket" {}