module "ecr_infinite_lambda" {
  source    = "cloudposse/ecr/aws"
  delimiter = "/"
  namespace = "test"
  name      = "infinite-lambda"

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}
