output "publicip" {
  
  value = aws_instance.myec2.public_ip

}