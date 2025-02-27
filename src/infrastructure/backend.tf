terraform {
  backend "s3" {
    bucket         = "terraform-backend-jale"
    key            = "lambda-start-ec2-airflow/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}