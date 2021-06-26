data "aws_iam_policy_document" "publicread" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject","s3:GetObjectVersion"]
    resources = [
      "arn:aws:s3:::infinite-lambda-website-s3-bucket",
      "arn:aws:s3:::infinite-lambda-website-s3-bucket/*"
    ]
  }

}

module "s3_infinite_lambda" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "infinite-lambda-website-s3-bucket"
  acl    = "private"
  force_destroy = true
  attach_policy = true
  policy = data.aws_iam_policy_document.publicread.json

  versioning = {
    enabled = true
  }

  website = {
    index_document = "index.html"
  }

  # block_public_acls       = true

}

output "s3_bucket_website_endpoint" {
  value = module.s3_infinite_lambda.s3_bucket_website_endpoint
  
}
