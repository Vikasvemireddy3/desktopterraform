terraform {
  backend "s3" {
    bucket = "projectterrform"
    key    = "sample"
    region = "ap-south-1"
  }
}
resource "aws_vpc" "vikas_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "tervpc"
  }
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.vikas_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subter"
  }
}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.vikas_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "subter2"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vikas_vpc.id

  tags = {
    Name = "tergw"
  }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vikas_vpc.id

  tags = {
    Name = "terrt"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_route_table_association" "b" {
  gateway_id     = aws_internet_gateway.gw.id
  route_table_id = aws_route_table.rt.id
}
