variable "env" {
  description = "The target environment"
  type        = string
}

variable "subnet" {
  description = "The subnet where CE resources will be created"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID that will be applied to all instances"
  type        = string
}

variable "iam_role_name" {
  description = "The IAM role name that will be applied to all instances"
  type        = string
}

variable "instances" {
  description = "A map of instances configurations"
  type = map(object({
    machine_type    = string
    network_ip      = string
    additional_tags = list(string)
  }))
}
