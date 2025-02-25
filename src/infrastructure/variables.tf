variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "lambda-start-ec2-airflow"
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "lambda-docker-repo"
}

variable "eventbridge_rule_name" {
  description = "The name of the EventBridge rule"
  type        = string
  default     = "daily-lambda-trigger"
}