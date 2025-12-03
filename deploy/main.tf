terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Bucket S3 para validar deploy nas contas
module "validation_bucket" {
  source = "./modules/s3-validation"
  
  customer_name    = var.customer_name
  project_name     = var.project_name
  environment_name = var.environment_name
  aws_region       = var.aws_region
  tags            = var.tags
}