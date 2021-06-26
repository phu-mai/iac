provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::546526969054:role/TFAssumeRole"
  }
  region     = "ap-southeast-1"
}
