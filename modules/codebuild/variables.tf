variable "customer_name" {
  description = "Nome do cliente"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "custom_role_name" {
  description = "Nome personalizado para a Role IAM do Pipeline"
  type        = string
  default     = ""
}

variable "environment_name" {
  description = "Nome do ambiente"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN da chave KMS para criptografia"
  type        = string
}

variable "artifact_bucket_name" {
  description = "Nome do bucket S3 para artifacts do pipeline"
  type        = string
}

variable "cross_account_role_arn" {
  description = "ARN da role cross-account (se necessária para o pipeline)"
  type        = string
  default     = "" # Dica: Deixando vazio ou default, ele não quebra se não for usado
}


variable "tags" {
  description = "Tags para aplicar aos recursos"
  type        = map(string)
  default     = {}
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