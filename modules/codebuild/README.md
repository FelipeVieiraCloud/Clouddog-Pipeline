# Módulo CodeBuild

Este módulo cria os projetos CodeBuild necessários para o pipeline de infraestrutura Terraform.

## Recursos Criados

- **terraform_codebuild_project_validate**: Projeto para validação e planejamento do Terraform
- **terraform_codebuild_project_apply**: Projeto para aplicação das mudanças do Terraform
- **buildspecs_fetcher**: Projeto para buscar buildspecs de uma conta cross-account
- **codebuild_terraform_role**: Role IAM para os projetos de Terraform
- **codebuild_buildspecs_role**: Role IAM para o projeto de busca de buildspecs

## Variáveis

| Nome | Descrição | Tipo | Padrão | Obrigatório |
|------|-----------|------|--------|-------------|
| customer_name | Nome do cliente | string | - | sim |
| project_name | Nome do projeto | string | - | sim |
| environment_name | Nome do ambiente | string | - | sim |
| kms_key_arn | ARN da chave KMS | string | - | sim |
| artifact_bucket_name | Nome do bucket de artifacts | string | - | sim |
| buildspecs_role_arn | ARN da role cross-account | string | - | sim |
| buildspecs_bucket_name | Nome do bucket de buildspecs | string | - | sim |
| buildspec_s3_key_validate | Chave S3 do buildspec de validação | string | buildspec_validate_plan.yml | não |
| buildspec_s3_key_apply | Chave S3 do buildspec de apply | string | buildspec_apply.yml | não |
| tags | Tags para os recursos | map(string) | {} | não |

## Outputs

| Nome | Descrição |
|------|-----------|
| codebuild_project_validate_name | Nome do projeto de validação |
| codebuild_project_apply_name | Nome do projeto de apply |
| codebuild_project_buildspecs_name | Nome do projeto de buildspecs |
| codebuild_terraform_role_arn | ARN da role do Terraform |
| codebuild_buildspecs_role_arn | ARN da role de buildspecs |

## Uso

```hcl
module "codebuild" {
  source = "./modules/codebuild"

  customer_name           = var.customer_name
  project_name           = var.project_name
  environment_name       = var.environment_name
  kms_key_arn           = module.kms.kms_key_arn
  artifact_bucket_name  = module.s3.artifact_bucket_name
  buildspecs_role_arn   = var.buildspecs_role_arn
  buildspecs_bucket_name = var.buildspecs_bucket_name
  tags                  = var.tags
}
```