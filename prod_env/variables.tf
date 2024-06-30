# PROVIDERS
variable "MAIN_REGION" {}
variable "SUB_REGION" {}

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
variable "DB_SUBNET_GROUP_NAME" {}
variable "DB_SUBNETS" {}

# S3
variable "STATIC_BUCKET_NAME" {}
variable "MJY_BUCKET" {}

# SECURITY GROUP
variable "APP_ALB_SG_NAME" {}
variable "APP_SG_NAME" {}
variable "DB_SG_NAME" {}

# RDS
variable "AURORA_CLUSTER_IDENTIFIER" {}
variable "RDS_USERNAME" {}
variable "RDS_PWD" {}
variable "RDS_NAME" {}
variable "DB_NAME" {}
variable "RDS_INSTANCE_CLASS" {}

# ALB
variable "APP_ELB_SUBNETS" {}
variable "APP_ALB_NAME" {}
variable "APP_TG_NAME" {}
variable "APP_LISTENER_NAME" {}

# CLOUDFRONT
variable "DOMAIN_NAME" {}
variable "ORIGIN_ID" {}
variable "TARGET_ORIGIN_ID" {}
variable "CDN_NAME" {}
variable "CACHE_POLICY_NAME" {}

# LAMBDA
variable "CDN_INVALIDATE_LAMBDA_ROLE" {}
variable "LAMBDA_FUNCTION_NAME" {}

# WAF
variable "WEB_ACL_NAME" {}