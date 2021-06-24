/*
// Commented out, but this is how to use the Lambda@Edge

resource "aws_cloudfront_distribution" "distribution" {
  # ...

  # or default_cache_behavior
  ordered_cache_behavior {
    # ...

    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = aws_lambda_function.security_headers_origin-response.qualified_arn
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = aws_lambda_function.security_txt_origin-request.qualified_arn
    }
  }
}
*/
