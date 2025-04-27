
# VPC
resource "aws_vpc" "readreplicavpc" {
  cidr_block           = "10.0.0.0/16"
  provider             = aws.secondary
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "readreplicavpc"
  }

}
# IG and attch to vpc
resource "aws_internet_gateway" "name" {
  vpc_id   = aws_vpc.readreplicavpc.id
  provider = aws.secondary

}
# Subnets 

resource "aws_subnet" "public1" {
  cidr_block        = "10.0.0.0/24"
  vpc_id            = aws_vpc.readreplicavpc.id
  availability_zone = "us-west-2a"
  provider          = aws.secondary


}

resource "aws_subnet" "public2" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.readreplicavpc.id
  availability_zone = "us-west-2b"
  provider          = aws.secondary

}

# RT, # edit routes 
resource "aws_route_table" "name" {
  vpc_id   = aws_vpc.readreplicavpc.id
  provider = aws.secondary
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}

# subnet associations
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.name.id
  provider       = aws.secondary

}
resource "aws_route_table_association" "name2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.name.id
  provider       = aws.secondary

}
