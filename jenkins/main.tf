provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "private" {
  ami           = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  
  tags = {
    Name = "myec2jenkins"
  }
}
