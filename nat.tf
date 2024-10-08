resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0) # Associate with the first public subnet
}

resource "aws_eip" "nat_eip" {
  # No need for 'vpc = true' as it's deprecated
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private_association" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}