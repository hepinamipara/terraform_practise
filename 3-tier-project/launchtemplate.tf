data "aws_ami" "frontami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["frontendimg"]
  }
}
resource "aws_launch_template" "frontend" {
  name                   = "frontend-terraform"
  description            = "frontend-terraform"
  image_id               = data.aws_ami.frontami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
  key_name               = "demokey" #chnage the key 
  #   user_data              = filebase64("${path.module}/frontend-lt.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-lt"
    }
  }
}

data "aws_ami" "backendimage" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["backendimg"]
  }

}

resource "aws_launch_template" "backend" {
  name                   = "backend-terraform"
  description            = "backend-terraform"
  image_id               = data.aws_ami.backendimage.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  key_name               = "demokey" #chnage the key 
  #   user_data              = filebase64("${path.module}/frontend-lt.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-lt"
    }
  }
}
