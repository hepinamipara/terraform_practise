# this is module which we can add through terraform official registry also

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr   = "10.0.0.0/16"
}
module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "newhepinbucket"
}
