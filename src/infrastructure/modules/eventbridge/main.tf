resource "aws_cloudwatch_event_rule" "invoke_lambda" {
  name                = "invoke-lambda-daily"
  description         = "Ejecuta la Lambda todos los días a las 10 AM UTC"
  schedule_expression = "cron(0 10 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.invoke_lambda.name
  arn       = var.lambda_arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.invoke_lambda.arn
}