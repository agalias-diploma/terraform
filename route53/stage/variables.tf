variable "region" {
  description = "The region where the resources will be created"
  type        = string
  default     = "eu-north-1"
}

variable "aws_profile" {
  description = "AWS profile for the account"
  type        = string
  default     = "agalias-ec2-user"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "agalias-project.online"
}
