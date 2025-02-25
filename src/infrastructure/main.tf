module "lambda" {
  source = "./modules/lambda"
  lambda_name = var.lambda_function_name
  ecr_repository_name = var.ecr_repository_name
}

module "eventbridge" {
  source = "./modules/eventbridge"
  rule_name = var.eventbridge_rule_name
  lambda_function_arn = module.lambda.lambda_function_arn
}

resource "aws_ecr_repository" "lambda_repo" {
  name = var.ecr_repository_name
}