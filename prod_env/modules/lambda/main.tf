resource "aws_lambda_function" "invalidate_cache" {
  filename      = "lambda_function.zip"
  function_name = var.lambda-function-name
  role          = data.aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"

  environment {
    variables = {
    CLOUDFRONT_DISTRIBUTION_ID = var.cloudfront-distribution-id }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.invalidate_cache.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.static_bucket.arn

  depends_on = [aws_lambda_function.invalidate_cache]
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = data.aws_s3_bucket.static_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.invalidate_cache.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}


resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = data.aws_s3_bucket.static_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCodeBuildAndCodePipeline",
        Effect    = "Allow",
        Principal = {
          Service = [
            "codebuild.amazonaws.com",
            "codepipeline.amazonaws.com"
          ]
        },
        Action    = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource  = "arn:aws:s3:::${var.static-bucket-name}/*"
      },
      {
        Sid       = "AllowCloudFrontAccess",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${var.static-bucket-name}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "${var.cloudfront-distribution-arn}"
          }
        }
      }
    ]
  })
}