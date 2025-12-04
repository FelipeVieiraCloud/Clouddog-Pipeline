output "codepipeline_arn" {
  value       = module.codepipeline_terraform.arn
  description = "The ARN of the Terraform CodePipeline"
}

output "codepipeline_name" {
  value       = module.codepipeline_terraform.name
  description = "The name of the Terraform CodePipeline"
}

output "iam_role_arn" {
  value       = module.codepipeline_iam_role.role_arn
  description = "The ARN of the IAM Role used by the CodePipeline"
}

output "kms_key_arn" {
  value       = module.codepipeline_kms.arn
  description = "The ARN of the KMS key used in the codepipeline"
}

output "s3_bucket_arn" {
  value       = module.s3_artifacts_bucket.arn
  description = "The ARN of the S3 Bucket for artifacts"
}

output "s3_bucket_name" {
  value       = module.s3_artifacts_bucket.bucket
  description = "The Name of the S3 Bucket for artifacts"
}

output "codebuild_plan_staging_project" {
  value       = module.codebuild_terraform.plan_staging_project_name
  description = "The name of the CodeBuild project for Plan Staging"
}

output "codebuild_apply_staging_project" {
  value       = module.codebuild_terraform.apply_staging_project_name
  description = "The name of the CodeBuild project for Apply Staging"
}

output "codebuild_plan_production_project" {
  value       = module.codebuild_terraform.plan_production_project_name
  description = "The name of the CodeBuild project for Plan Production"
}

output "codebuild_apply_production_project" {
  value       = module.codebuild_terraform.apply_production_project_name
  description = "The name of the CodeBuild project for Apply Production"
}