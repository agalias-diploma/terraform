variable "project" {
  description = "The project ID where VPC resources will be created"
  type        = string
}

variable "env" {
  description = "The target environment"
  type        = string
}

variable "region" {
  description = "The region where subnetworks will be created"
  type        = string
}
