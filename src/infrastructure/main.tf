module "lambda" {
  source = "./modules/lambda"
  aws_account_id = var.AWS_ACCOUNT_ID
  ecr_repository_name = var.AWS_ECR_REPO_NAME
  lambda_name = var.lambda_name
  aws_region = var.aws_region
}

module "eventbridge" {
  source = "./modules/eventbridge"
  rule_name = var.eventbridge_rule_name
  lambda_name = var.lambda_name
  lambda_arn = module.lambda.lambda_arn
}
