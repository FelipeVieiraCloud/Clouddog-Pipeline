variable "project_name" {
  description = "Nome único do projeto"
  type        = string
}

variable "customer_name" {
  description = "Nome do cliente"
  type        = string
}

variable "custom_role_name" {
  description = "Nome da role IAM"
  type        = string
  default     = ""
}


variable "source_type" {
  description = "Tipo de provedor de código (CodeCommit, GitHub)"
  type        = string
  default     = "CodeCommit"
  validation {
    condition     = contains(["CodeCommit", "GitHub"], var.source_type)
    error_message = "Source type deve ser CodeCommit ou GitHub."
  }
}

variable "source_repo_name" {
  description = "Nome do repositório (CodeCommit repo ou GitHub owner/repo)"
  type        = string
}

variable "source_repo_branch" {
  description = "Branch padrão do repositório"
  type        = string
  default     = "main"
}

variable "codestar_connection_arn" {
  description = "ARN da conexão CodeStar (obrigatório para GitHub)"
  type        = string
  default     = null
}

variable "create_new_codecommit_repo" {
  description = "Criar novo repositório CodeCommit"
  type        = bool
  default     = false
}

variable "stg_account_id" {
  description = "ID da conta AWS de Staging"
  type        = string
}

variable "prod_account_id" {
  description = "ID da conta AWS de Produção"
  type        = string
}

variable "stg_role_arn" {
  description = "ARN da role de deploy na conta de Staging"
  type        = string
}

variable "prod_role_arn" {
  description = "ARN da role de deploy na conta de Produção"
  type        = string
}

variable "stack_name" {
  description = "Nome da stack SAM para deploy"
  type        = string
}

variable "tags" {
  description = "Tags para recursos AWS"
  type        = map(string)
  default     = {}
}

variable "environment_name" {
  description = "Nome do ambiente (dev, stg, prod)"
  type        = string
  default     = "prod"
}

variable "aws_region" {
  description = "A região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1" 
}

variable "cross_account_role_arn" {
  description = "ARN da role cross-account (se necessária para o pipeline)"
  type        = string
  default     = "" # Dica: Deixando vazio ou default, ele não quebra se não for usado
}