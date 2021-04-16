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

  function_name = "lambda@edge-origin_response"

  runtime = "nodejs12.x"

  role = aws_iam_role.lambda_edge_exec.arn

  # us-west-1 is important, this is where Lambda@Edge are deployed from:
  provider = aws.us_east_1

  # versions are required, so publish needs to be true:
  publish = true

  # use the variables to set a header
  # 'NULL' means the header won't be set
  environment {
    variables = {
      # DELETE_SRV_HEADER = "false"
      # HEADER_STS        = "NULL"
      # HEADER_EXPECTCT   = "NULL"
      # HEADER_CSP        = "NULL"
      # HEADER_XCTO       = "NULL"
      # HEADER_XFO        = "NULL"
      # HEADER_XSSP       = "NULL"
      # HEADER_RF         = "NULL"
      # HEADER_PP         = "NULL"
      # HEADER_FP         = "NULL"
      # HEADER_COEP       = "NULL"
      # HEADER_COOP       = "NULL"
      # HEADER_CORP       = "NULL"
    }
  }
}