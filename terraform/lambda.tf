resource "aws_iam_role" "lambda_exec" {
  name = "${var.name_prefix}_serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda_hello_world" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/../hello-world/target/hello-world-0.0.1-SNAPSHOT-aws.jar"
  function_name = "${var.name_prefix}_hello_world"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "org.springframework.cloud.function.adapter.aws.FunctionInvoker::handleRequest"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  #   source_code_hash = "${base64sha256(file("./hello_world/hello_world.zip"))}"
  source_code_hash = filebase64sha256("${path.module}/../hello-world/target/hello-world-0.0.1-SNAPSHOT-aws.jar")

  runtime = "java11"
  memory_size = 256
  timeout = 20
}

resource "aws_cloudwatch_log_group" "log_group_lambda" {
  name = "/aws/lambda/${aws_lambda_function.lambda_hello_world.function_name}"

  retention_in_days = 30
}