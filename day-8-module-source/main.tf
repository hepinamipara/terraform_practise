resource "aws_instance" "myec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
}

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket
}