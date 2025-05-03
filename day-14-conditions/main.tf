# example-1 s3 bucket creation condition based 

# variable "create_bucket" {
#   description = "Set to true to create the S3 bucket."
#   type        = bool
#   default     = true
# }

# resource "aws_s3_bucket" "example" {
#   count  = var.create_bucket ? 1 : 0 # check condition it true than create bucket 
#   bucket = "hepinbucket"
#   acl    = "private"

#   tags = {
#     Name        = "ConditionalBucket"
#     Environment = "Dev"
#   }
# }


#example-2
# variable "aws_region" {
#   description = "The region in which to create the infrastructure"
#   type        = string
#   default     = "us-west-2" #here we need to define either us-west-2 or eu-west-1 if i give other region will get error 

#   validation {
#     condition     = var.aws_region == "us-west-2" || var.aws_region == "eu-west-1"
#     error_message = "it check if true region using or operator"
#   }
# }

# provider "aws" {
#   region = "us-west-2"

# }

# resource "aws_s3_bucket" "dev" {
#   bucket = "hepinbucket"

# }

#example-03 using variable.tf numeric condition
resource "aws_instance" "myec2" {
  ami           = var.ami
  instance_type = var.type
  count         = var.type == "t2.micro" ? 1 : 0
}


