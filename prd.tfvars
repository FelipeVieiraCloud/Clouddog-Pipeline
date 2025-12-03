#========================================================================================#
#                                  CUSTOMER VARIABLES                                    #
#========================================================================================#

customer_name    = "nibi"
environment_name = "devops"
aws_region       = "us-east-1"
# nome da aplicação ou projeto
project_name = "beeconnect"

tags = {
  Owner       = "CloudDog"
  Environment = "prod"
  Project     = "Migration"
  Cost_center = "Nibi"
  Managed_by  = "Terraform"
}
#========================================================================================#
#                                  PIPELINE VARIABLES                                    #
#========================================================================================#


#========================================================================================#
#                                  SOURCE VARIABLES                                      #
#========================================================================================#

# Tipo de fonte: "CodeCommit", "GitHub", Azure ou "S3"
source_type             = "GitHub"
source_repo_branch      = "main"
source_repo_name        = "FelipeVieiraCloud/Clouddog-Pipeline"
codestar_connection_arn = "arn:aws:codeconnections:sa-east-1:102306345761:connection/ed05521f-3e7f-4bb0-8936-7915366b1715"

# Criar novo repositório CodeCommit (apenas para source_type = "CodeCommit")
create_new_codecommit_repo = false

#========================================================================================#
#                                  DEPLOYMENT VARIABLES                                  #
#========================================================================================#

# IDs das contas AWS para deploy cross-account para as conta
stg_account_id = "624497742426"  # Substitua pelo ID da conta de staging
prod_account_id = "943706828868"  # Substitua pelo ID da conta de produção

# ARNs das roles para deploy cross-account
stg_role_arn = "arn:aws:iam::624497742426:role/CLOUDDOG_PIPELINE_TEST_STG"  # Substitua pelo ARN da role de staging
prod_role_arn = "arn:aws:iam::943706828868:role/CLOUDDOG_PIPELINE_TEST_PRD"  # Substitua pelo ARN da role de produção

# Nome da stack SAM para deploy
stack_name = "clouddog-test-pipeline-stack-terraform"
