output "plan_staging_project_name" {
  description = "Nome do projeto CodeBuild Plan Staging"
   value       = aws_codebuild_project.terraform_codebuild_project_plan_stg.name
}

output "apply_staging_project_name" {
  description = "Nome do projeto CodeBuild Apply Staging"
  value       = aws_codebuild_project.terraform_codebuild_project_apply_stg.name
}

output "plan_production_project_name" {
  description = "Nome do projeto CodeBuild Plan Production"
  value       = aws_codebuild_project.terraform_codebuild_project_plan_prod.name
}

output "apply_production_project_name" {
  description = "Nome do projeto CodeBuild Apply Production"
  value       = aws_codebuild_project.terraform_codebuild_project_apply_prod.name
}

output "codebuild_terraform_role_arn" {
  description = "ARN da role do CodeBuild para Terraform"
  value       = aws_iam_role.codebuild_terraform_role.arn
}