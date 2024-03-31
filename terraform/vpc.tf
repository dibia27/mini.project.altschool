resource "aws_vpc" "webVPC" {
  cidr_block       = var.cidr_block[0]
  instance_tenancy = "default"

  tags = {
    Name = var.tags[0]
  }
}