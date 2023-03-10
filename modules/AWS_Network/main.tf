data "aws_availability_zones" "avaible" {}
#==================================VPC=========================================================
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}_My_vpc"
  }
}
#==============================================================================================

#========================================IGW===================================================
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}_My_igw"
  }
}
#==============================================================================================

#=======================================Nat=GW=================================================
resource "aws_eip" "nat" {
  count = length(var.privat_subnet_cidrs)
  vpc   = true
  tags = {
    "Name" = "${var.env}_nat_gw_${count.index + 1}"
  }
}
resource "aws_nat_gateway" "nat" {
  count         = 1 #length(var.privat_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.public_subnet[*].id, count.index)
  tags = {
    "Name" = "${var.env}_nat_gw_${count.index + 1}"
  }
}

#==============================================================================================

#==================================PublicSubnet================================================
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.avaible.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}_public_${count.index + 1}"
  }
}
#==============================================================================================

#==============================================================================================
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-north-1a"
}
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-north-1b"
}
#==============================================================================================

#==================================PrivatSubnet================================================
resource "aws_subnet" "privat_subnet" {
  count             = length(var.privat_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.privat_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.avaible.names[count.index]
  tags = {
    Name = "${var.env}_privat_${count.index + 1}"
  }
}
#==============================================================================================

#========================================Route Table to Privat Subnet==========================
resource "aws_route_table" "privat_subnet" {
  count  = length(var.privat_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[0].id
  }
  tags = {
    Name = "${var.env}_route_privat_${count.index + 1}"
  }
}
resource "aws_route_table_association" "privat_route" {
  count          = length(aws_subnet.privat_subnet[*].id)
  route_table_id = aws_route_table.privat_subnet[count.index].id
  subnet_id      = element(aws_subnet.privat_subnet[*].id, count.index)
}

#=============================================================================================

#========================================Route Table to Public Subnet==========================
resource "aws_route_table" "public_subnet" {
  count  = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.env}_route_public_${count.index + 1}"
  }
}
resource "aws_route_table_association" "public_route" {
  count          = length(aws_subnet.public_subnet[*].id)
  route_table_id = aws_route_table.public_subnet[count.index].id
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
}

#=============================================================================================

#=============================================================================================
