# PROVIDERS
variable "MAIN_REGION" {}
variable "EIP_NAME" {}
variable "NGW_NAME" {}

# VPC
variable "VPC_NAME" {}
variable "VPC_CIDR" {}
variable "IGW_NAME" {}
variable "NGW_COUNT" {}
variable "PUBLIC_ROUTE_TABLE" {}
variable "PRIVATE_ROUTE_TABLE" {}
variable "AZ_COUNT" {}
variable "PUBLIC_SUBNET_NEWBITS" {}
variable "PRIVATE_SUBNET_NEWBITS" {}
variable "PUBLIC_SUBNET_COUNT" {}
variable "PRIVATE_SUBNET_COUNT" {}
variable "PUBLIC_SUBNET_NAME" {}
variable "PRIVATE_SUBNET_NAME" {}

# SECURITY GROUP
variable "APP_SG_NAME" {}
variable "DB_SG_NAME" {}

# INSTANCE
variable "DB_INSTANCE_AMI" {}
variable "APP_INSTANCE_AMI" {}
variable "INSTANCE_TYPE" {}
variable "KEY_PAIR_NAME" {}
variable "EC2_PROFILE_NAME" {}
variable "DOMAIN_NAME" {}
variable "SUBNET" {}
variable "DEV_STATIC_BUCKET" {}
