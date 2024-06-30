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
}

module "security-group" {
  source = "./modules/security-group"

  vpc-name = var.VPC_NAME
  app-sg-name     = var.APP_SG_NAME
  db-sg-name      = var.DB_SG_NAME

  depends_on = [module.vpc]
}

module "instance" {
  source = "./modules/aws-instance"

  db-instance-ami = var.DB_INSTANCE_AMI
  app-instance-ami = var.APP_INSTANCE_AMI
  instance-type = var.INSTANCE_TYPE
  key-pair-name = var.KEY_PAIR_NAME
  ec2-profile-name = var.EC2_PROFILE_NAME
  domain-name = var.DOMAIN_NAME

  db-sg-name = var.DB_SG_NAME
  private-subnet-name = var.PRIVATE_SUBNET_NAME
  subnet = var.SUBNET
  app-sg-name         = var.APP_SG_NAME
  public-subnet-name = var.PUBLIC_SUBNET_NAME
  dev-static-bucket = var.DEV_STATIC_BUCKET

  depends_on = [ module.security-group ]
}