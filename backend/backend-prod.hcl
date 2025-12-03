bucket         = "terraform-state-prd-labs"
key            = "pipeline-test/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-lock-prd"
encrypt        = true