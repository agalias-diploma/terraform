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
  default     = "agalias-ec2-user" # it's getting aws IAM user from ~/.aws/credentials
}

variable "project" {
  description = "Project ID where firewall resources will be created"
  type        = string
  default     = "agalias-diploma"
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
