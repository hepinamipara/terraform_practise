resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.dev.id
  cidr_block = "10.0.0.0/24"
}



