variable "customer_name" {
  description = "Nome do cliente"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "environment_name" {
  description = "Nome do ambiente"
  type        = string
}

variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}