variable "network" {
  description = "Network where firewall resources will be created"
  type        = string
}

variable "ingress_rules" {
  description = "A map of ingress rule configurations"
  type = map(object({
    name  = string
    ports = list(number)
  }))
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}
