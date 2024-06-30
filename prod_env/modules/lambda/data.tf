data "aws_iam_role" "lambda_exec_role" {
  name = var.cdn-invalidate-lambda-role
}

data "aws_s3_bucket" "static_bucket" {
  bucket = var.static-bucket-name
}