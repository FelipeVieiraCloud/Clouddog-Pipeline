#========================================================================================#
#                                  CUSTOMER VARIABLES                                    #
#========================================================================================#

customer_name    = "nibi"
environment_name = "prod"
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
codestar_connection_arn = "arn:aws:codeconnections:us-east-1:102306345761:connection/5cb4a7ee-1898-45ce-b97a-b09e91841e10"

# Criar novo repositório CodeCommit (apenas para source_type = "CodeCommit")
create_new_codecommit_repo = false

#========================================================================================#
#                                  DEPLOYMENT VARIABLES                                  #
#========================================================================================#

# IDs das contas AWS para deploy cross-account para as conta
stg_account_id = "624497742426"  # Conta de staging
prod_account_id = "943706828868"  # Conta de produção

# ARNs das roles para deploy cross-account
stg_role_arn = "arn:aws:iam::624497742426:role/CLOUDDOG_PIPELINE_TEST_STG"
prod_role_arn = "arn:aws:iam::943706828868:role/CLOUDDOG_PIPELINE_TEST_PRD"

# Nome da stack SAM para deploy
stack_name = "nibi-beeconnect-prod-terraform"