resource "aws_ecr_repository" "this" {
  name  = var.ecr_repository_name
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
}