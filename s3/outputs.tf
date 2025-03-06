output "terraform_state_bucket" {
  description = "Terraform state storage S3 bucket name"
  value       = aws_s3_bucket.terraform_state_files.id
}

output "terraform_state_bucket_arn" {
  description = "ARN of the Terraform state S3 bucket"
  value       = aws_s3_bucket.terraform_state_files.arn
}

output "templates_bucket" {
  description = "S3 bucket for storing template files"
  value       = aws_s3_bucket.agalias_templates.id
}

output "templates_bucket_arn" {
  description = "ARN of the templates S3 bucket"
  value       = aws_s3_bucket.agalias_templates.arn
}
