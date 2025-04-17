resource "aws_instance" "newec2" {
  ami = var.ami
  instance_type = var.type  
  tags =  {
    Name = "mynewserver"
  }

}

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket
}