bucket         = "terraform-state-stg-labs"
key            = "deploy-validation/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-lock-stg"
encrypt        = true