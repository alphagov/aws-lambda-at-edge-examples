// --- security headers origin response ---

data "archive_file" "lambda_zip_security_headers" {
  type        = "zip"
  output_path = "lambda_zip_file_int.zip"
  source {
    content  = file("../origin_response/security_headers/src/origin_response.js")
    filename = "origin_response.js"
  }
}

resource "aws_lambda_function" "security_headers_origin-response" {
  filename         = data.archive_file.lambda_zip_security_headers.output_path
  source_code_hash = data.archive_file.lambda_zip_security_headers.output_base64sha256
  handler          = "origin_response.handler"

  function_name = "lambda@edge-security_headers-origin_response"

  runtime = "nodejs12.x"

  role = aws_iam_role.lambda_edge_exec.arn

  # us-east-1 is important, this is where Lambda@Edge are deployed from:
  provider = aws.us_east_1

  # versions are required, so publish needs to be true:
  publish = true

  # Lambda@Edge doesn't support environment variables.
}

// --- security.txt origin request ---

data "archive_file" "lambda_zip_security_txt" {
  type        = "zip"
  output_path = "lambda_zip_file_int.zip"
  source {
    content  = file("../origin_request/security.txt/src/origin_request.js")
    filename = "origin_request.js"
  }
}

resource "aws_lambda_function" "security_txt_origin-request" {
  filename         = data.archive_file.lambda_zip_security_txt.output_path
  source_code_hash = data.archive_file.lambda_zip_security_txt.output_base64sha256
  handler          = "origin_request.handler"

  function_name = "lambda@edge-security_txt-origin_request"

  runtime = "nodejs12.x"

  role = aws_iam_role.lambda_edge_exec.arn

  # us-east-1 is important, this is where Lambda@Edge are deployed from:
  provider = aws.us_east_1

  # versions are required, so publish needs to be true:
  publish = true

  # Lambda@Edge doesn't support environment variables.
}
