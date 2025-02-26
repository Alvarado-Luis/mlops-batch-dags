variable "eventbridge_rule_name" {
  description = "The name of the EventBridge rule"
  type        = string
  default     = "daily-lambda-trigger"
}


variable "lambda_arn" {
    description = "The arn of the Lambda function"
    type        = string

}

variable "lambda_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "lambda-start-ec2-airflow"
}

variable "AWS_ACCOUNT_ID" {
  type = string
}

variable "AWS_ECR_REPO_NAME" {
  type = string
}