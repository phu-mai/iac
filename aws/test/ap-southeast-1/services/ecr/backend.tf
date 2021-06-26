terraform {
  backend "s3" {
    bucket  = "infinite-lambda-iac-terraform-remote-state"
    encrypt = true
    key     = "aws/test/ap-southeast-1/services/ecr"
    region  = "ap-southeast-1"
  }
}
