resource "aws_instance" "name" {
  ami = var.ami
  instance_type = var.type  
  tags =  {
    Name = "terraserver"
  }
  count = 1
  key_name = "linux"
}