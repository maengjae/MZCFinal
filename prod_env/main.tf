module "vpc" {
  source = "./modules/aws-vpc"

  region-name          = var.MAIN_REGION
  vpc-name             = var.VPC_NAME
  vpc-cidr             = var.VPC_CIDR
  igw-name             = var.IGW_NAME
  eip-names            = local.EIP_NAMES
  ngw-count            = var.NGW_COUNT
  ngw-names            = local.NGW_NAMES
  public-subnet-info   = local.PUBLIC_SUBNET_INFO
  private-subnet-info  = local.PRIVATE_SUBNET_INFO
  public-subnet-name   = var.PUBLIC_SUBNET_NAME
  private-subnet-name  = var.PRIVATE_SUBNET_NAME
  public-route-table   = var.PUBLIC_ROUTE_TABLE
  private-route-table  = var.PRIVATE_ROUTE_TABLE
  db-subnet-group-name = var.DB_SUBNET_GROUP_NAME
  db-subnets           = var.DB_SUBNETS
}


module "security-group" {
  source = "./modules/security-group"

  vpc-name = var.VPC_NAME
  app-alb-sg-name = var.APP_ALB_SG_NAME
  app-sg-name     = var.APP_SG_NAME
  db-sg-name      = var.DB_SG_NAME

  depends_on = [module.vpc]
}


module "rds" {
  source = "./modules/aws-rds"

  aurora-cluster-identifier = var.AURORA_CLUSTER_IDENTIFIER
  vpc-name                  = var.VPC_NAME
  db-subnet-group-name      = var.DB_SUBNET_GROUP_NAME
  private-subnet-name       = var.PRIVATE_SUBNET_NAME
  db-subnets                = var.DB_SUBNETS
  db-sg-name                = var.DB_SG_NAME
  azs = data.aws_availability_zones.AZS.names
  rds-username              = var.RDS_USERNAME
  rds-pwd                   = var.RDS_PWD
  db-name                   = var.DB_NAME
  rds-name                  = var.RDS_NAME
  rds-instance-class = var.RDS_INSTANCE_CLASS

  depends_on = [module.security-group]
}


module "alb" {
  source = "./modules/alb-tg"

  public-subnet-name  = var.PUBLIC_SUBNET_NAME
  private-subnet-name = var.PRIVATE_SUBNET_NAME
  app-elb-subnets   = var.APP_ELB_SUBNETS
  app-alb-sg-name   = var.APP_ALB_SG_NAME
  app-alb-name      = var.APP_ALB_NAME
  app-tg-name       = var.APP_TG_NAME
  app-listener-name = var.APP_LISTENER_NAME
  vpc-name          = var.VPC_NAME
  domain-name       = var.DOMAIN_NAME
  mjy-bucket = var.MJY_BUCKET

  depends_on = [module.rds]
}

module "route53" {
  source = "./modules/aws-waf-cdn-acm-route53"

  providers = {
    aws = aws.sub
  }

  domain-name          = var.DOMAIN_NAME
  static-bucket-domain = data.aws_s3_bucket.mjy-static.bucket_regional_domain_name
  origin-id         = var.ORIGIN_ID
  target-origin-id  = var.TARGET_ORIGIN_ID
  cdn-name          = var.CDN_NAME
  web_acl_name      = var.WEB_ACL_NAME
  app-alb-name      = module.alb.app-alb-name
  app-alb-zone      = module.alb.app-alb-zone
  cache_policy_name = var.CACHE_POLICY_NAME
  bucket-domain-name = data.aws_s3_bucket.mjy-bucket.bucket_domain_name

  depends_on = [module.alb]
}

module "lambda" {
  source = "./modules/lambda"

  cdn-invalidate-lambda-role = var.CDN_INVALIDATE_LAMBDA_ROLE
  lambda-function-name       = var.LAMBDA_FUNCTION_NAME
  cloudfront-distribution-id = module.route53.cloudfront-distribution-id
  static-bucket-name  = var.STATIC_BUCKET_NAME
  cloudfront-distribution-arn = module.route53.cloudfront-distribution-arn
  depends_on = [ module.route53 ]
}