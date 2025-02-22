module "lambda" {
  source             = "./modules/lambda"
  lambda_name        = "my-docker-lambda"
  ecr_repository_name = "my-lambda-repo"
}

module "eventbridge" {
  source      = "./modules/eventbridge"
  lambda_arn  = module.lambda.lambda_arn
  lambda_name = module.lambda.lambda_name
}