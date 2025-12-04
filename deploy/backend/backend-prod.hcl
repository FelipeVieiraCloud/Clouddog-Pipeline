bucket         = "terraform-state-prod-labs"
key            = "deploy-validation/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-lock-prod"
encrypt        = true