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
source_repo_name        = "kaykeperes-clouddog/Teste-Terraform-NIBI"
codestar_connection_arn = "arn:aws:codeconnections:us-east-1:985740016014:connection/0112219d-4182-4871-8e27-3016f3cdf4bf"

# Criar novo repositório CodeCommit (apenas para source_type = "CodeCommit")
create_new_codecommit_repo = false

#========================================================================================#
#                                  DEPLOYMENT VARIABLES                                  #
#========================================================================================#

# IDs das contas AWS para deploy cross-account para as conta
stg_account_id = "925323749102"  # Substitua pelo ID da conta de staging
prod_account_id = "562311163774"  # Substitua pelo ID da conta de produção

# ARNs das roles para deploy cross-account
stg_role_arn = "arn:aws:iam::925323749102:role/NIBI-BEECONNECT-STG"  # Substitua pelo ARN da role de staging
prod_role_arn = "arn:aws:iam::562311163774:role/NIBI-BEECONNECT-PRD"  # Substitua pelo ARN da role de produção

# Nome da stack SAM para deploy
stack_name = "nibi-migration-stack-terraform"
