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

variable "ami" {
  description = "The AMI ID for the instances"
  type        = string
  default = "ami-02e2af61198e99faf" # Free tier Ubuntu 22.04 64-bit (x86)
}

variable "ssh-key" {
  description = "The SSH key name for the instances"
  type        = string
  default = "agalias-personal-ec2-instances-ssh"
}

variable "instances" {
  description = "A map of instances configurations"
  type = map(object({
    machine_type    = string
    network_ip      = string
    additional_tags = map(string)
  }))
}
