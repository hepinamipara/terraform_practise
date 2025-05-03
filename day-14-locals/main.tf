# variable → external input (from user, CLI, tfvars)
# local → internal computed values (used inside your Terraform code only)
# using locals clearly shows: “This value is calculated and not meant to be changed from outside.”
# It avoids confusion for people reading your code later.
locals {
  region        = "us-east-1"
  instance_type = "t2.micro"
  Name          = "myec2"
}

resource "aws_instance" "example" {
  ami           = "ami-00a929b66ed6e0de6"
  instance_type = local.instance_type
  tags = {
    Name = "${local.Name}-${local.region}"
  }
}
