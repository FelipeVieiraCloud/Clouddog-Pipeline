output "validation_bucket_name" {
  description = "Nome do bucket de validação"
  value       = module.validation_bucket.bucket_name
}

output "validation_bucket_arn" {
  description = "ARN do bucket de validação"
  value       = module.validation_bucket.bucket_arn
}