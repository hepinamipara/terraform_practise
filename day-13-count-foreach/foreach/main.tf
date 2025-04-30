variable "ami" {
  type    = string
  default = "ami-00a929b66ed6e0de6"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance-name" {
  type    = list(string)
  default = ["myinstance-1", "myinstance-2", "myinstance-3"]
}

resource "aws_instance" "myec2" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.instance-name)
  #   count = length(var.env)  

  tags = {
    Name = each.value
  }
}
