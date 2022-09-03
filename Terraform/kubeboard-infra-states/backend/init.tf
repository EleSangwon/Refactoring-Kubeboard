provider "aws" {
  profile = var.profile
  region  = var.aws_region
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "kubeboard-tfstates"

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}