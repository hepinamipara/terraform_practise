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
#subnet private-3
resource "aws_subnet" "pvt3" {
  cidr_block        = "10.0.64.0/19"
  vpc_id            = aws_vpc.vpc3tier.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "private3-1a"
  }
}
#subnet private-4
resource "aws_subnet" "pvt4" {
  cidr_block        = "10.0.96.0/19"
  vpc_id            = aws_vpc.vpc3tier.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "private4-1b"
  }
}
#subnet private-5
resource "aws_subnet" "pvt5" {
  cidr_block        = "10.0.128.0/19"
  vpc_id            = aws_vpc.vpc3tier.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "private5-1a"
  }

}
#subnet private-6
resource "aws_subnet" "pvt6" {
  cidr_block        = "10.0.160.0/19"
  vpc_id            = aws_vpc.vpc3tier.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "private6-1b"
  }
}
#subnet private-7
resource "aws_subnet" "pvt7" {
  cidr_block        = "10.0.192.0/19"
  vpc_id            = aws_vpc.vpc3tier.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "private7-1a"
  }
}
#subnet private-8
resource "aws_subnet" "pvt8" {
  cidr_block        = "10.0.224.0/19"
  vpc_id            = aws_vpc.vpc3tier.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "private8-1b"
  }
}

#internet gateway
resource "aws_internet_gateway" "myig" {
  vpc_id = aws_vpc.vpc3tier.id
  tags = {
    Name = "ig-3-tier"
  }
}

#route table  public
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc3tier.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myig.id
  }

  tags = {
    Name = "public-route-table-3tier"
  }
}


#route association public subnet
resource "aws_route_table_association" "public-1a" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.pub1.id
}

resource "aws_route_table_association" "public-1b" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.pub2.id
}

resource "aws_eip" "eip" {

}
resource "aws_nat_gateway" "mynat" {
  subnet_id         = aws_subnet.pub1.id
  connectivity_type = "public"
  allocation_id     = aws_eip.eip.id
  tags = {
    Name = "mynat"
  }
}

#private route table
resource "aws_route_table" "pvtroutetable" {
  vpc_id = aws_vpc.vpc3tier.id
  tags = {
    Name = "privatert3tier"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat.id
  }
}

#  attaching prvt-3a subnet to private route table
resource "aws_route_table_association" "prvivate-3a" {
  route_table_id = aws_route_table.pvtroutetable.id
  subnet_id      = aws_subnet.pvt3.id
}

#  attaching prvt-4b subnet to private route table
resource "aws_route_table_association" "prvivate-4b" {
  route_table_id = aws_route_table.pvtroutetable.id
  subnet_id      = aws_subnet.pvt4.id
}

#  attaching prvt-5a subnet to private route table
resource "aws_route_table_association" "prvivate-5a" {
  route_table_id = aws_route_table.pvtroutetable.id
  subnet_id      = aws_subnet.pvt5.id
}

#  attaching prvt-6b subnet to private route table
resource "aws_route_table_association" "prvivate-6b" {
  route_table_id = aws_route_table.pvtroutetable.id
  subnet_id      = aws_subnet.pvt6.id
}

#  attaching prvt-7a subnet to private route table
resource "aws_route_table_association" "prvivate-7a" {
  route_table_id = aws_route_table.pvtroutetable.id
  subnet_id      = aws_subnet.pvt7.id
}

#  attaching prvt-8b subnet to private route table
resource "aws_route_table_association" "prvivate-8b" {
  route_table_id = aws_route_table.pvtroutetable.id
  subnet_id      = aws_subnet.pvt8.id
}
