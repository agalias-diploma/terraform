variable "env" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.20.10.0/24"
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.20.10.0/26", "10.20.10.64/26"]
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.20.10.128/26", "10.20.10.192/26"]
}

variable "additional_tags" {
  description = "Additional tags for VPC resources"
  type        = map(string)
  default     = {}
}
