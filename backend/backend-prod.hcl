bucket         = "terraform-state-prd-123456789012"
key            = "pipeline-test/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-lock-prd"
encrypt        = true