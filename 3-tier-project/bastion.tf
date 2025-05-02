resource "aws_instance" "bastion" {
    ami = "ami-00a929b66ed6e0de6"
    instance_type = "t2.micro"
    key_name = "demokey"
    subnet_id = aws_subnet.pub1.id
    vpc_security_group_ids = [aws_security_group.bastion-host.id ]
    tags = {
      Name= "bastion-server"
    }
}