resource "aws_s3_bucket" "terraform_state_files" {
  bucket = var.terraform_state_bucket_name
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state_files.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "agalias_templates" {
  bucket = var.templates_bucket_name
}

resource "aws_s3_bucket" "aws_s3_bucket_agalias_react_build_files" {
  bucket = var.terraform_react_build_bucket_name
}

resource "aws_s3_bucket_versioning" "react_build_files_versioning" {
  bucket = aws_s3_bucket.aws_s3_bucket_agalias_react_build_files.id
  versioning_configuration {
    status = "Enabled"
  }
}
