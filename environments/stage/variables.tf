variable "iam_role_name" {
  description = "The IAM role name to associate with EC2 instances"
  type        = string
  default     = "ec2-iam-role"
}

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

variable "ingress_rules" {
  description = "A list of ingress rules"
  type = map(object({
    name  = string
    ports = list(number)
  }))
  default = {
    ssh = {
      name  = "ssh"
      ports = [22]
    },
    http = {
      name  = "http"
      ports = [80]
    },
    allow-backend = {
      name  = "allow-backend"
      ports = [3000]
    },
    allow-frontend = {
      name  = "allow-frontend"
      ports = [4000]
    },
    https = {
      name  = "https"
      ports = [443]
    }
  }
}

variable "mongodb_atlas_public_key" {
  description = "MongoDB Atlas public key"
  type        = string
  sensitive   = true
}

variable "mongodb_atlas_private_key" {
  description = "MongoDB Atlas private key"
  type        = string
  sensitive   = true
}

variable "mongodb_atlas_project_id" {
  description = "MongoDB Atlas project ID"
  type        = string
}
