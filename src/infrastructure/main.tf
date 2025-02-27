resource "aws_lambda_function" "airflow_lambda" {
  function_name = "airflow_lambda"
  package_type  = "Image"
  image_uri     = "${var.AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${var.AWS_ECR_REPO_NAME}:latest"
  role          = aws_iam_role.lambda_role.arn
  timeout       = 60
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_logs" {
  name       = "lambda_logs"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_cloudwatch_event_rule" "daily_event" {
  name                = "daily_event"
  schedule_expression = "cron(0 10 * * ? *)"  # 10 AM UTC
}

resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.daily_event.name
  arn       = aws_lambda_function.airflow_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.airflow_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_event.arn
}