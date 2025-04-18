resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "mysubnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.myvpc.id
  depends_on = [ aws_vpc.myvpc ]
}

resource "aws_instance" "myec2" {
    ami = "ami-00a929b66ed6e0de6"
    instance_type = "t2.micro"
    depends_on = [ aws_subnet.mysubnet ]
  
}

