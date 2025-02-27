output "lambda_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.airflow_lambda.arn
}

output "eventbridge_rule_arn" {
  description = "ARN de la regla de EventBridge"
  value       = aws_cloudwatch_event_rule.daily_event.arn
}