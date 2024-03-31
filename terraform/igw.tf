resource "aws_internet_gateway" "webServersGW" {
  vpc_id = aws_vpc.webVPC.id

  tags = {
    Name = var.tags[5]
  }
}