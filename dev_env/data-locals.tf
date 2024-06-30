data "aws_availability_zones" "AZS" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.MAIN_REGION]
  }
}

#local variables
locals {
  PUBLIC_SUBNETS = [
    for i in range(var.PUBLIC_SUBNET_COUNT) : cidrsubnet(var.VPC_CIDR, var.PUBLIC_SUBNET_NEWBITS, i)
  ]
  PRIVATE_SUBNETS = [
    for i in range(var.PRIVATE_SUBNET_COUNT) : cidrsubnet(var.VPC_CIDR, var.PRIVATE_SUBNET_NEWBITS, i + 10)
  ]
  PUBLIC_SUBNET_INFO = {
    for i in range(var.PUBLIC_SUBNET_COUNT) :
    "${var.PUBLIC_SUBNET_NAME}${i + 1}" => {
      cidr = local.PUBLIC_SUBNETS[i]
      az   = data.aws_availability_zones.AZS.names[i % var.AZ_COUNT]
    }
  }

  PRIVATE_SUBNET_INFO = {
    for i in range(var.PRIVATE_SUBNET_COUNT) :
    "${var.PRIVATE_SUBNET_NAME}${i + 1}" => {
      cidr = local.PRIVATE_SUBNETS[i]
      az   = data.aws_availability_zones.AZS.names[i % var.AZ_COUNT]
    }
  }
}

#local names
locals {
  EIP_NAMES = [
    for i in range(var.NGW_COUNT) : "${var.EIP_NAME}${i}"
  ]
  NGW_NAMES = [
    for i in range(var.NGW_COUNT) : "${var.NGW_NAME}${i}"
  ]
}