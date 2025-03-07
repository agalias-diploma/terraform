variable "terraform_state_bucket_name" {
  description = "S3 bucket name for storing Terraform state files"
  type        = string
  default     = "agalias-terraform-state-files"
}

variable "templates_bucket_name" {
  description = "S3 bucket for storing template files"
  type        = string
  default     = "agalias-templates"
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-north-1"
}
