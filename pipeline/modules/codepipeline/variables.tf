variable "customer_name" {
  description = "Nome do cliente"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "tags" {
  description = "Tags aplicadas aos recursos"
  type        = map(any)
}

# -------------------------
# 🔹 Source configuration
# -------------------------
variable "source_type" {
  description = "Tipo do repositório fonte: CodeCommit, GitHub ou S3"
  type        = string
  validation {
    condition     = contains(["CodeCommit", "GitHub", "S3"], var.source_type)
    error_message = "Source type must be CodeCommit, GitHub, or S3."
  }
}

variable "source_repo_name" {
  description = "Nome do repositório (CodeCommit) ou owner/repo (GitHub)"
  type        = string
}

variable "source_repo_branch" {
  description = "Branch padrão do repositório fonte"
  type        = string
  default     = "main"
}

variable "codestar_connection_arn" {
  description = "ARN da conexão CodeStar (necessário para GitHub)"
  type        = string
  default     = null
}

variable "s3_source_bucket" {
  description = "Bucket S3 usado como fonte (para source_type = S3)"
  type        = string
  default     = null
}

variable "s3_source_key" {
  description = "Objeto dentro do S3 usado como source"
  type        = string
  default     = null
}

# -------------------------
# 🔹 Artifacts & Encryption
# -------------------------
variable "s3_bucket_name" {
  description = "Bucket S3 que armazena os artefatos do CodePipeline"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN da chave KMS usada para encriptar artefatos"
  type        = string
}

# -------------------------
# 🔹 IAM
# -------------------------
variable "codepipeline_role_arn" {
  description = "ARN da IAM Role usada pelo CodePipeline"
  type        = string
}

# -------------------------
# 🔹 Cross Account
# -------------------------
variable "cross_account_role_arn" {
  description = "ARN da role assumida pelo pipeline para acessar outras contas"
  type        = string
}

variable "stg_account_id" {
  description = "ID da conta de Staging"
  type        = string
}

variable "prod_account_id" {
  description = "ID da conta de Produção"
  type        = string
}

# -------------------------
# 🔹 SAM Deploy
# -------------------------
variable "stack_name" {
  description = "Nome da stack SAM utilizada nos builds de deploy"
  type        = string
}