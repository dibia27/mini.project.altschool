resource "aws_route_table" "webServersRoute" {
  vpc_id = aws_vpc.webVPC.id

  tags = {
    Name = var.tags[4]
  }
}

resource "aws_route_table_association" "webServersRouteAssoc1" {
  subnet_id      = aws_subnet.webPubSunet1.id
  route_table_id = aws_route_table.webServersRoute.id
}

resource "aws_route_table_association" "webServersRouteAssoc2" {
  subnet_id      = aws_subnet.webPubSunet2.id
  route_table_id = aws_route_table.webServersRoute.id
}

resource "aws_route_table_association" "webServersRouteAssoc3" {
  subnet_id      = aws_subnet.webPubSunet3.id
  route_table_id = aws_route_table.webServersRoute.id
}

resource "aws_route" "webServersRoute" {
  gateway_id             = aws_internet_gateway.webServersGW.id
  route_table_id         = aws_route_table.webServersRoute.id
  destination_cidr_block = var.cidr_block[4]
} 