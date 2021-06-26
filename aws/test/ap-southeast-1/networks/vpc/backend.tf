terraform {
  backend "s3" {
    bucket  = "infinite-lambda-iac-terraform-remote-state"
    encrypt = true
    key     = "iac/aws/test/ap-southeast-1/networks/vpc"
    region  = "ap-southeast-1"
  }
}
