#VPC
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"

}

#subnet public/private
resource "aws_subnet" "public" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.dev.id
}

resource "aws_subnet" "private" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.dev.id
}

#ig
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.dev.id
}

#route table
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.myrt.id
}

resource "aws_security_group" "sgnew" {
  name   = "allow"
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "mysg"
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #all protocols 
    cidr_blocks = ["0.0.0.0/0"]

  }
}
resource "aws_eip" "myip" {
  #   vpc = true  old version 
  domain = "vpc" #new version
}

resource "aws_nat_gateway" "name" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.myip.id
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.name.id
  }
}
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table" "myrtnat" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.name.id
  }
}


resource "aws_instance" "name" {
  ami                         = "ami-00a929b66ed6e0de6"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.sgnew.id]
  tags = {
    Name = "public_server"
  }
}


resource "aws_instance" "private" {
  ami                         = "ami-00a929b66ed6e0de6"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private.id
  associate_public_ip_address = false
  key_name                    = "linux"

  vpc_security_group_ids = [aws_security_group.sgnew.id]
  tags = {
    Name = "Private_server"
  }
}



