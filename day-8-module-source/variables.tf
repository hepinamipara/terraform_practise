# this is template for where other can use
variable "aws_region" {
  default = ""
}

variable "instance_name" {
  default = ""
}

variable "ami_id" {
  default = "" # Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  default = ""
}

variable "subnet_id" {
    default = ""
}
variable "vpc_id" {
    default = ""
}
variable "key_name" {
    default = ""
}
variable "bucket" {
  default = ""
}