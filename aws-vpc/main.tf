resource "aws_vpc" "vpc-claxton" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc-claxton.id
  count                   = length(var.public_subnet)
  cidr_block              = element(values(var.public_subnet), count.index)
  availability_zone       = element(keys(var.public_subnet), count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc-claxton.id
  count             = length(var.private_subnet)
  cidr_block        = element(values(var.private_subnet), count.index)
  availability_zone = element(keys(var.private_subnet), count.index)
}

resource "aws_db_subnet_group" "private_db_group" {
  name       = "db subnet group private"
  subnet_ids = aws_subnet.private.*.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc-claxton.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = var.cidr_world
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "route_private_association" {
  count          = length(var.private_subnet)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-claxton.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc-claxton.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.cidr_world
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "route_public_association" {
  count          = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

