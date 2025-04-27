module "mymod" {
  source = "./modules/instance"
  ami_id  = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  
}

module "mymod2" {
  source = "./modules/bucket"
  bucket = "hepinbucket"
}