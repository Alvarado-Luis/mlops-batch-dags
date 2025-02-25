variable "rule_name" {
  description = "The name of the EventBridge rule"
  type        = string
}

variable "lambda_arn" {
    description = "The arn of the Lambda function"

}
variable "lambda_name" {
    description = "The name of the Lambda function"
}