# PROVIDER
MAIN_REGION = "us-east-2"
EIP_NAME = "mjy-dev-eip"
NGW_NAME = "mjy-dev-ngw"

# VPC
VPC_NAME               = "MJY_DEV_VPC"
VPC_CIDR               = "10.0.0.0/16"
IGW_NAME               = "MJY_DEV_IGW"
NGW_COUNT              = 1
AZ_COUNT               = 2
PUBLIC_SUBNET_NEWBITS  = 8
PRIVATE_SUBNET_NEWBITS = 6
PUBLIC_SUBNET_COUNT    = 2
PRIVATE_SUBNET_COUNT   = 2
PUBLIC_SUBNET_NAME     = "mjy-dev-PublicSubnet"
PRIVATE_SUBNET_NAME    = "mjy-dev-PrivateSubnet"
PUBLIC_ROUTE_TABLE     = "mjy-dev-PublicRouteTable"
PRIVATE_ROUTE_TABLE    = "mjy-dev-PrivateRouteTable"

# SECURITY  GROUP
APP_SG_NAME     = "mjy-dev-app-sg"
DB_SG_NAME      = "mjy-dev-db-sg"

# ECS
DB_INSTANCE_AMI = "ami-09040d770ffe2224f"
APP_INSTANCE_AMI = "ami-02bf8ce06a8ed6092"
INSTANCE_TYPE = "t3.micro"
KEY_PAIR_NAME = "mjy-key-pair"
EC2_PROFILE_NAME = "mjy-dev-ssm-role"
DOMAIN_NAME = "jaejae.store"
SUBNET = "1"
DEV_STATIC_BUCKET = "mjy-static-test-deploy"
