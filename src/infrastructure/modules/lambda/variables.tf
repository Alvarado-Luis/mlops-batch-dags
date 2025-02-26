variable "lambda_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}