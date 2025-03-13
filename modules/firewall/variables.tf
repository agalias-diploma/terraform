variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where to create security groups"
  type        = string
}

variable "ingress_rules" {
  description = "Map of ingress rules for different services"
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    http = {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    https = {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ssh = {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    backend_api = {
      description = "Backend API"
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    frontend = {
      description = "Frontend app"
      from_port   = 4000
      to_port     = 4000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
