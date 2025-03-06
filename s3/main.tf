resource "aws_s3_bucket" "terraform_state_files" {
  bucket = "agalias-terraform-state-files"
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state_files.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "agalias_templates" {
  bucket = "agalias-templates"
}
