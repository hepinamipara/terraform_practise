resource "aws_vpc" "vpc3tier" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "3-tier-vpc"
  }
}

#subnet public-1
resource "aws_subnet" "pub1" {
  cidr_block              = "10.0.0.0/19"
  vpc_id                  = aws_vpc.vpc3tier.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true # for auto asign public ip for subnet
  tags = {
    Name = "pub-1a"
  }
}
#subnet public-2
resource "aws_subnet" "pub2" {
  cidr_block              = "10.0.32.0/19"
  vpc_id                  = aws_vpc.vpc3tier.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true # for auto asign public ip for subnet
  tags = {
    Name = "pub-1b"
  }
}