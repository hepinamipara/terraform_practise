terraform {
  backend "s3" {
    bucket = "hepinbucket1"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
