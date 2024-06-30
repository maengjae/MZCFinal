# Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    Name       = var.vpc-name
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name       = var.igw-name
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
  depends_on = [aws_vpc.vpc]
}

# Creating Elastic IP for NAT Gateways
resource "aws_eip" "eip" {
  count  = var.ngw-count
  domain = "vpc"

  tags = {
    Name       = var.eip-names[count.index]
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
  depends_on = [aws_vpc.vpc]
}

# Creating Public Subnets for Load Balancers and ngw
resource "aws_subnet" "public-subnets" {
  for_each = var.public-subnet-info

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name       = each.key
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
  depends_on = [aws_internet_gateway.igw]
}


# Creating Private Subnets 
resource "aws_subnet" "private-subnets" {
  for_each = var.private-subnet-info

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = {
    Name       = each.key
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
  depends_on = [aws_subnet.public-subnets]
}


# Creating NAT Gateways
resource "aws_nat_gateway" "ngw" {
  count         = var.ngw-count
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public-subnets["${var.public-subnet-name}${count.index + 1}"].id

  tags = {
    Name       = var.ngw-names[count.index]
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }

  depends_on = [aws_subnet.public-subnets]
}



# Creating Public Route tables
resource "aws_route_table" "public-rts" {
  count = length(var.public-subnet-info)

  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name       = "${var.public-route-table}${count.index + 1}"
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}

# Associating the Public Route tables
resource "aws_route_table_association" "public-rt-associations" {
  count = length(var.public-subnet-info)

  subnet_id      = aws_subnet.public-subnets["${var.public-subnet-name}${count.index + 1}"].id
  route_table_id = aws_route_table.public-rts[count.index].id
}

# Creating Private Route tables
resource "aws_route_table" "private-rts" {
  count = length(var.private-subnet-info)

  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw[count.index % var.ngw-count].id
  }

  tags = {
    Name       = "${var.private-route-table}${count.index + 1}"
    owner      = "mjy"
    createDate = formatdate("YYYY MM DD", timestamp())
  }
}

# Associating the Private Route tables
resource "aws_route_table_association" "private-rt-associations" {
  count = length(var.private-subnet-info)

  subnet_id      = aws_subnet.private-subnets["${var.private-subnet-name}${count.index + 1}"].id
  route_table_id = aws_route_table.private-rts[count.index].id
}


# 8 Creating DB subnet group for aurora Instances
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db-subnet-group-name
  subnet_ids = [for i in var.db-subnets : aws_subnet.private-subnets["${var.private-subnet-name}${i}"].id]
}
