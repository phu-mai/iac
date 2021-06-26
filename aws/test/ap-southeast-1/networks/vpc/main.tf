module "vpc_infinite_lambda_test" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "vpc-infinite-lambda-test"
  cidr    = "100.100.0.0/16"

  azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets  = ["100.100.0.0/24","100.100.1.0/24", "100.100.2.0/24"]
  database_subnets = ["100.100.3.0/24","100.100.4.0/24", "100.100.5.0/24"]
  public_subnets   = ["100.100.6.0/24","100.100.7.0/24", "100.100.8.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = true
  enable_dns_hostnames   = true

  tags = {
    Environment   = "infinite-lambda-test"
    Terraform     = "true"
  }
}
