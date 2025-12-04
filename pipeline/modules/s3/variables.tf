#This solution, non-production-ready template describes AWS Codepipeline based CICD Pipeline for terraform code deployment.
#© 2023 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
#This AWS Content is provided subject to the terms of the AWS Customer Agreement available at
#http://aws.amazon.com/agreement or other written agreement between Customer and either
#Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.
variable "customer_name" {
  description = "Nome do cliente"
  type        = string
}

variable "project_name" {
  description = "Name of the project to be prefixed to create the s3 bucket"
  type        = string
}
variable "tags" {
  description = "Tags to be associated with the S3 bucket"
  type        = map(any)
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "ARN of the codepipeline IAM role"
  type        = string
}

variable "stg_role_arn" {
  description = "ARN da role de cross-account do ambiente Staging"
  type        = string
}

variable "prod_role_arn" {
  description = "ARN da role de cross-account do ambiente Produção"
  type        = string
}

variable "environment_name" {
  description = "Nome do ambiente (stg, prod, etc)"
  type        = string
}