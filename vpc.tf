resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
