module "ecr" {
  source = "./modules/ecr"
  ecr_repository_name = var.AWS_ECR_REPO_NAME
}

module "lambda" {
  source = "./modules/lambda"
  aws_region = var.aws_region
  aws_account_id = var.AWS_ACCOUNT_ID
  ecr_repository_name = var.AWS_ECR_REPO_NAME
  lambda_name = var.lambda_name
}

module "eventbridge" {
  source = "./modules/eventbridge"
  rule_name = var.eventbridge_rule_name
  lambda_name = var.lambda_name
  lambda_arn = module.lambda.lambda_arn
}
