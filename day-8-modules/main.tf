module "mymod" {
    source = "../day-8-module-source"
    ami_id = "ami-00a929b66ed6e0de6"
    instance_type = "t2.micro"
    bucket  = "hepinbucket"
    
}
    
