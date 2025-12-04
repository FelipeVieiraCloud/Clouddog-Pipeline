#Artifact Bucket

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.customer_name}-${var.project_name}-${var.environment_name}-artifacts-labs-terraform-v4"
  tags          = var.tags
  force_destroy = true
}


