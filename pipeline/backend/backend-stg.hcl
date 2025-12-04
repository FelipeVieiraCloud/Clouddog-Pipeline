bucket         = "terraform-state-stg-labs"
key            = "pipeline-test/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-lock-stg"
encrypt        = true