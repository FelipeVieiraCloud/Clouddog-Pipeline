resource "aws_s3_bucket" "validation_bucket" {
  bucket = "${var.customer_name}-${var.project_name}-${var.environment_name}-validation-labs"
  
  tags = merge(var.tags, {
    Purpose   = "Pipeline Validation"
    CreatedBy = "Terraform Pipeline"
    Resource  = "S3 Bucket"
  })
}

resource "aws_s3_bucket_versioning" "validation_bucket_versioning" {
  bucket = aws_s3_bucket.validation_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "validation_bucket_encryption" {
  bucket = aws_s3_bucket.validation_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "validation_bucket_pab" {
  bucket = aws_s3_bucket.validation_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}