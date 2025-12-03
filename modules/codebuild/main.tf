resource "aws_codebuild_project" "terraform_codebuild_project_build_stg" {

  name           = "${var.customer_name}-${var.project_name}-build-stg-terraform"
  service_role   = aws_iam_role.codebuild_terraform_role.arn
  encryption_key = var.kms_key_arn
  tags           = var.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "STACK_NAME"
      value = var.stack_name
    }
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_validate_plan_stg.yml"
  }
}

resource "aws_codebuild_project" "terraform_codebuild_project_plan_prod" {
  name           = "${var.customer_name}-${var.project_name}-plan-prod-terraform"
  service_role   = aws_iam_role.codebuild_terraform_role.arn
  encryption_key = var.kms_key_arn
  tags           = var.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "STACK_NAME"
      value = var.stack_name
    }
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_validate_plan_prod.yml"
  }
}

resource "aws_codebuild_project" "terraform_codebuild_project_deploy_stg" {

  name           = "${var.customer_name}-${var.project_name}-deploy-stg-terraform"
  service_role   = aws_iam_role.codebuild_terraform_role.arn
  encryption_key = var.kms_key_arn
  tags           = var.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "STG_ROLE_ARN"
      value = var.stg_role_arn
    }
    environment_variable {
      name  = "STACK_NAME"
      value = var.stack_name
    }
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_apply_stg.yml"
}
}

resource "aws_codebuild_project" "terraform_codebuild_project_deploy_prod" {

  name           = "${var.customer_name}-${var.project_name}-deploy-prod-terraform"
  service_role   = aws_iam_role.codebuild_terraform_role.arn
  encryption_key = var.kms_key_arn
  tags           = var.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "PRD_ROLE_ARN"
      value = var.prod_role_arn
    }
    environment_variable {
      name  = "STACK_NAME"
      value = var.stack_name
    }
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
  
  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_apply_prod.yml"
  }
}


# ---------------------------------------------------------------------------
# 1. O Documento da Política (Com a correção de Cross-Account que fizemos)
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "codebuild_terraform" {
  statement {
    sid     = "PipelineArtifactsS3"
    actions = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
    resources = [
      "arn:aws:s3:::${var.artifact_bucket_name}",
      "arn:aws:s3:::${var.artifact_bucket_name}/*"
    ]
  }

  statement {
    sid     = "PipelineArtifactsKms"
    actions = ["kms:Decrypt", "kms:Encrypt", "kms:DescribeKey", "kms:GenerateDataKey*"]
    resources = [var.kms_key_arn]
  }

  #  O BLOCO CRUCIAL PARA O DEPLOY FUNCIONAR
  statement {
    sid     = "CrossAccountAccess"
    actions = ["sts:AssumeRole"]
    resources = [
      var.stg_role_arn,
      var.prod_role_arn
    ]
  }

  statement {
    sid = "CloudWatchLogs"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    sid = "TerraformResourceCreation"
    actions = [
      "ec2:*",
      "rds:*",
      "elasticloadbalancing:*",
      "ecs:*",
      "iam:*",
      "lambda:*",
      "sns:*",
      "budgets:*",
      "acm:*",
      "s3:*",
      "cloudfront:*",
      "secretsmanager:*",
      "logs:*",
      "kms:*",
      "mq:*",
      "elasticache:*"
    ]
    resources = ["*"]
  }
}

# ---------------------------------------------------------------------------
# 2. A Política de Confiança (Quem pode usar essa role? O CodeBuild)
# ---------------------------------------------------------------------------
data "aws_iam_policy_document" "codebuild_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

# ---------------------------------------------------------------------------
# 3. A Criação da ROLE (O recurso que estava faltando!)
# ---------------------------------------------------------------------------
resource "aws_iam_role" "codebuild_terraform_role" {
  name               = "${var.customer_name}-${var.project_name}-code-build-role-terraform-v3"
  assume_role_policy = data.aws_iam_policy_document.codebuild_trust.json
  
  tags = merge(
    var.tags,
    {
      Workload       = "pipeline"
      ClouddogVendor = "clouddog"
      principaltype  = "Role"
    }
  )
}

# ---------------------------------------------------------------------------
# 4. A Criação da POLICY (Baseada no documento do passo 1)
# ---------------------------------------------------------------------------
resource "aws_iam_policy" "codebuild_terraform_policy" {
  name   = "${var.customer_name}-${var.project_name}-codebuild-terraform-policy-v3"
  policy = data.aws_iam_policy_document.codebuild_terraform.json
}

# ---------------------------------------------------------------------------
# 5. O Anexo (Grudando a Policy na Role)
# ---------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "codebuild_terraform_attach" {
  role       = aws_iam_role.codebuild_terraform_role.name
  policy_arn = aws_iam_policy.codebuild_terraform_policy.arn
}