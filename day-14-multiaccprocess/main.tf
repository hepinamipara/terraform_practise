provider "aws" {
  profile = "dev"
  alias   = "account1"
}

provider "aws" {
  profile = "test"
  alias   = "account2"


}

resource "aws_s3_bucket" "test_profile" {
  bucket   = "hepinbucket1"
  provider = aws.account2

}
resource "aws_s3_bucket" "dev_profile" {
  bucket   = "hepinbucket2"
  provider = aws.account1

}
