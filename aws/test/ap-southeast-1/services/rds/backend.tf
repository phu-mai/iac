data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = {
    region  = "ap-southeast-1"
    bucket  = "infinite-lambda-iac-terraform-remote-state"
    key     = "iac/aws/test/ap-southeast-1/networks/vpc"
  }
}

terraform {
  backend "s3" {
    bucket  = "infinite-lambda-iac-terraform-remote-state"
    encrypt = true
    key     = "aws/test/ap-southeast-1/services/rds"
    region  = "ap-southeast-1"
  }
}
