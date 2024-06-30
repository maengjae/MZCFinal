# PROVIDER
MAIN_REGION = "us-east-2"
SUB_REGION  = "us-east-1"

# VPC
VPC_NAME               = "mjy_prod_vpc"
VPC_CIDR               = "10.0.0.0/16"
IGW_NAME               = "mjy_prod_igw"
NGW_COUNT              = 2
AZ_COUNT               = 2
PUBLIC_SUBNET_NEWBITS  = 8
PRIVATE_SUBNET_NEWBITS = 6
PUBLIC_SUBNET_COUNT    = 2
PRIVATE_SUBNET_COUNT   = 4
PUBLIC_SUBNET_NAME     = "PublicSubnet"
PRIVATE_SUBNET_NAME    = "PrivateSubnet"
PUBLIC_ROUTE_TABLE     = "PublicRouteTable"
PRIVATE_ROUTE_TABLE    = "PrivateRouteTable"
DB_SUBNET_GROUP_NAME   = "mjy-db-subnet-group"
DB_SUBNETS             = ["3", "4"]

# S3
STATIC_BUCKET_NAME = "mjy-static-deploy"
MJY_BUCKET = "mjy-bucket"

# SECURITY  GROUP
APP_ALB_SG_NAME = "mjy-prod-app-albsg"
APP_SG_NAME     = "mjy-prod-app-sg"
DB_SG_NAME      = "mjy-prod-db-sg"

# RDS
AURORA_CLUSTER_IDENTIFIER = "mjy-aurora-cluster"
RDS_USERNAME              = "admin"
RDS_PWD                   = "adminadmin"
RDS_NAME                  = "MJY_AURORA"
DB_NAME                   = "fullstack"
RDS_INSTANCE_CLASS = "db.t3.medium"

# ALB
APP_ELB_SUBNETS           = ["1", "2"]
APP_ALB_NAME              = "mjy-prod-app-alb"
APP_TG_NAME               = "mjy-prod-app-tg"
APP_LISTENER_NAME         = "mjy-prod-app-listener"

# CLOUDFRONT
DOMAIN_NAME       = "jaejae.store"
ORIGIN_ID         = "mjy-origin"
TARGET_ORIGIN_ID  = "mjy-origin"
CDN_NAME          = "mjy-cdn"
CACHE_POLICY_NAME = "mjy-cache-policy"

# LAMBDA
CDN_INVALIDATE_LAMBDA_ROLE = "mjy-lambda-role"
LAMBDA_FUNCTION_NAME       = "mjy-cacheinvalidate"

# WAF
WEB_ACL_NAME = "mjy-waf"