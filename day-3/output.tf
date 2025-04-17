output "key_name" {
    value = aws_instance.newec2.key_name    
}
output "publicip" {
  value = aws_instance.newec2.public_ip
}
output "privateip" {
  value = aws_instance.newec2.private_ip
  sensitive = true
}
output "s3bucketarn" {
  value = aws_s3_bucket.mybucket.arn
}