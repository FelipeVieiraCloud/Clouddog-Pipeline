resource "aws_codepipeline" "terraform_pipeline" {

  name     = "${var.customer_name}-${var.project_name}-pipeline-terraform"
  role_arn = var.codepipeline_role_arn
  tags     = var.tags

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
    encryption_key {
      id   = var.kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    # CodeCommit Source
    dynamic "action" {
      for_each = var.source_type == "CodeCommit" ? [1] : []
      content {
        name             = "TerraformSource"
        category         = "Source"
        owner            = "AWS"
        version          = "1"
        provider         = "CodeCommit"
        namespace        = "SourceVariables"
        output_artifacts = ["TerraformSource"]
        run_order        = 1

        configuration = {
          RepositoryName = var.source_repo_name
          BranchName     = var.source_repo_branch
        }
      }
    }

    # GitHub Source
    dynamic "action" {
      for_each = var.source_type == "GitHub" ? [1] : []
      content {
        name             = "TerraformSource"
        category         = "Source"
        owner            = "AWS"
        version          = "1"
        provider         = "CodeStarSourceConnection"
        namespace        = "SourceVariables"
        output_artifacts = ["TerraformSource"]
        run_order        = 1

        configuration = {
          ConnectionArn    = var.codestar_connection_arn
          FullRepositoryId = var.source_repo_name
          BranchName       = var.source_repo_branch
        }
      }
    }

    # S3 Source
    dynamic "action" {
      for_each = var.source_type == "S3" ? [1] : []
      content {
        name             = "TerraformSource"
        category         = "Source"
        owner            = "AWS"
        version          = "1"
        provider         = "S3"
        namespace        = "SourceVariables"
        output_artifacts = ["TerraformSource"]
        run_order        = 1

        configuration = {
          S3Bucket    = var.s3_source_bucket
          S3ObjectKey = var.s3_source_key
        }
      }
    }
  }

  stage {
    name = "Plan-Staging"

    action {
      name             = "PlanStaging"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["TerraformSource"]
      output_artifacts = ["PlanStagingOutput"]
      version          = "1"
      run_order        = 1

      configuration = {
        ProjectName   = "${var.customer_name}-${var.project_name}-build-stg-terraform"
        PrimarySource = "TerraformSource"
      }
    }
  }

  stage {
    name = "Approval-Staging"

    action {
      name      = "ManualApprovalStaging"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 1
    }
  }

  stage {
    name = "Apply-Staging"

    action {
      name             = "ApplyStaging"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["TerraformSource", "PlanStagingOutput"]
      output_artifacts = ["ApplyStagingOutput"]
      version          = "1"
      run_order        = 1

      configuration = {
        ProjectName   = "${var.customer_name}-${var.project_name}-deploy-stg-terraform"
        PrimarySource = "TerraformSource"
      }
    }
  }

  stage {
    name = "Approval-Production-Start"

    action {
      name      = "ManualApprovalProductionStart"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 1
    }
  }

  stage {
    name = "Plan-Production"

    action {
      name             = "PlanProduction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["TerraformSource"]
      output_artifacts = ["PlanProductionOutput"]
      version          = "1"
      run_order        = 1

      configuration = {
        ProjectName   = "${var.customer_name}-${var.project_name}-plan-prod-terraform"
        PrimarySource = "TerraformSource"
      }
    }
  }

  stage {
    name = "Approval-Production"

    action {
      name      = "ManualApprovalProduction"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 1
    }
  }

  stage {
    name = "Apply-Production"

    action {
      name             = "ApplyProduction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["TerraformSource", "PlanProductionOutput"]
      output_artifacts = ["ApplyProductionOutput"]
      version          = "1"
      run_order        = 1

      configuration = {
        ProjectName   = "${var.customer_name}-${var.project_name}-deploy-prod-terraform"
        PrimarySource = "TerraformSource"
      }
    }
  }
}