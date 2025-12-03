# S3 bucket for storing pipeline artifacts
module "s3_artifacts_bucket" {
  source                = "./modules/s3"
  project_name          = var.project_name
  customer_name         = var.customer_name 
  kms_key_arn           = module.codepipeline_kms.arn
  codepipeline_role_arn = module.codepipeline_iam_role.role_arn
  tags                  = var.tags
  stg_role_arn = var.stg_role_arn
  prod_role_arn = var.prod_role_arn
}

# Terraform Build project
module "codebuild_terraform" {
  source = "./modules/codebuild"

  customer_name        = var.customer_name
  project_name         = var.project_name
  environment_name     = var.environment_name 
  kms_key_arn          = module.codepipeline_kms.arn
  artifact_bucket_name = module.s3_artifacts_bucket.bucket
  stg_role_arn         = var.stg_role_arn
  prod_role_arn         = var.prod_role_arn
  stack_name           = var.stack_name
  tags                 = var.tags
}

# KMS key for pipeline encryption
module "codepipeline_kms" {
  source                = "./modules/kms"
  codepipeline_role_arn = module.codepipeline_iam_role.role_arn
  tags                  = var.tags
}

# Main Terraform pipeline with cross-account deployment
module "codepipeline_terraform" {
  source = "./modules/codepipeline"

  project_name            = var.project_name
  customer_name           = var.customer_name
  source_type             = var.source_type
  source_repo_name        = var.source_repo_name
  source_repo_branch      = var.source_repo_branch
  codestar_connection_arn = var.codestar_connection_arn
  s3_bucket_name          = module.s3_artifacts_bucket.bucket
  codepipeline_role_arn   = module.codepipeline_iam_role.role_arn
  kms_key_arn             = module.codepipeline_kms.arn
  stg_account_id          = var.stg_account_id
  prod_account_id          = var.prod_account_id
  stack_name              = var.stack_name
  tags                    = var.tags
  cross_account_role_arn = var.cross_account_role_arn
}

# IAM role for CodePipeline
module "codepipeline_iam_role" {
  source = "./modules/iam-role"

  customer_name          = var.customer_name
  project_name           = var.project_name
  source_repository_name = var.source_repo_name
  kms_key_arn            = module.codepipeline_kms.arn
  s3_bucket_arn          = module.s3_artifacts_bucket.arn
  stg_role_arn           = var.stg_role_arn
  prod_role_arn           = var.prod_role_arn
  tags                   = var.tags
  cross_account_role_arn    = var.cross_account_role_arn
  environment_name       = var.environment_name
  codestar_connection_arn = var.codestar_connection_arn 
}