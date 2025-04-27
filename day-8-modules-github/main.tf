# this is module which we can add through git hub reposiroty but we can not push the code with git hub repolink

module "mymodule" {
  source = "github.com/hepinamipara/terraform_practise/day-8-module-source"
  ami_id = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
  bucket = "nmynewbuckethepin"
}