data "archive_file" "lambda_zip_origin-response" {
  type        = "zip"
  output_path = "lambda_zip_file_int.zip"
  source {
    content  = file("../origin_response/src/origin_response.js")
    filename = "origin_response.js"
  }
}

resource "aws_lambda_function" "lambda-at-edge_origin-response" {
  filename         = data.archive_file.lambda_zip_origin-response.output_path
  source_code_hash = data.archive_file.lambda_zip_origin-response.output_base64sha256
  handler          = "origin_response.handler"

  function_name = "lambda@edge-origin_response"

  runtime = "nodejs12.x"

  role = aws_iam_role.lambda_edge_exec.arn

  # us-east-1 is important, this is where Lambda@Edge are deployed from:
  provider = aws.us_east_1

  # versions are required, so publish needs to be true:
  publish = true

  # Lambda@Edge doesn't support environment variables.
}
