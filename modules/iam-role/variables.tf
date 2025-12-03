variable "source_repository_name" {
  type        = string
  description = "Name of the Source CodeCommit repository"
}

variable "project_name" {
  description = "Unique name for this project"
  type        = string
}

variable "customer_name" {
  description = "Nome do cliente"
  type        = string
}

variable "environment_name" {
  description = "Nome do ambiente (ex: tooling, shared, pipeline)"
  type        = string
}

variable "custom_role_name" {
  description = "Nome da role IAM"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to be attached to the IAM Role"
  type        = map(any)
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 Bucket"
  type        = string
}

variable "create_new_role" {
  type        = bool
  description = "Flag for deciding if a new role needs to be created"
  default     = true
}

variable "s3_state_bucket_arn" {
  type        = string
  description = "Flag for deciding if a new role needs to be created"
  default     = "talkradio-prod-tfstate"
}


variable "stg_role_arn" {
  description = "ARN da role de deploy na conta de Staging"
  type        = string
}

variable "prod_role_arn" {
  description = "ARN da role de deploy na conta de Produção"
  type        = string
}

variable "cross_account_role_arn" {
  description = "ARN da role cross-account (se necessária para o pipeline)"
  type        = string
  default     = "" # Dica: Deixando vazio ou default, ele não quebra se não for usado
}

variable "codestar_connection_arn" {
  description = "ARN da conexão CodeStar para GitHub"
  type        = string
}