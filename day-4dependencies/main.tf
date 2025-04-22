# resource "aws_vpc" "myvpc" {
#   cidr_block = "10.0.0.0/16"
# }
# resource "aws_subnet" "mysubnet" {
#   cidr_block = "10.0.0.0/24"
#   vpc_id = aws_vpc.myvpc.id
#   depends_on = [ aws_vpc.myvpc ]
# }

# resource "aws_instance" "myec2" {
#     ami = "ami-00a929b66ed6e0de6"
#     instance_type = "t2.micro"
#     depends_on = [ aws_subnet.mysubnet ]
  
# }

#creating s3 bucket and dynamo DB for state backend storgae and applying the lock mechanisam for statefile

#for practising day-5 state locking using dynamo db
resource "aws_s3_bucket" "mybucket" {
  bucket = "hepinbucket1"
  
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}