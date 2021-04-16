/*
// Commented out, but this is how to use the Lambda@Edge

resource "aws_cloudfront_distribution" "distribution" {
  # ...

  # or default_cache_behavior
  ordered_cache_behavior {
    # ...

    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = aws_lambda_function.lambda-at-edge_origin-response.qualified_arn
    }
  }
}
*/
