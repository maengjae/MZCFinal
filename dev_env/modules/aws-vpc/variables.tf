variable "region-name" {}
variable "vpc-name" {}
variable "vpc-cidr" {}
variable "igw-name" {}
variable "eip-names" {
  type = list(string)
}
variable "ngw-count" {}
variable "ngw-names" {
  type = list(string)
}
variable "public-subnet-info" {
  type = map(object({
    cidr = string
    az   = string
  }))
}
variable "private-subnet-info" {
  type = map(object({
    cidr = string
    az   = string
  }))
}
variable "public-subnet-name" {}
variable "private-subnet-name" {}
variable "public-route-table" {}
variable "private-route-table" {}