locals {
  env = "agalias-diploma-stage"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${local.env}-vpc"
  cidr = "10.20.10.0/24"

  azs             = ["eu-north-1a"]
  private_subnets = ["10.20.10.0/26", "10.20.10.64/26"]
  public_subnets  = ["10.20.10.128/26", "10.20.10.192/26"]

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  enable_vpn_gateway   = false

  tags = {
    Name = "${local.env}-vpc"
    env  = local.env
  }
}

# Create EC2 instances in the VPC with security group and subnet references
module "ec2" {
  source = "../../modules/ec2"
  env    = local.env

  instances = {
    frontend = {
      machine_type    = "t3.micro"
      network_ip      = "10.20.10.135"
      additional_tags = ["Name=agalias-diploma/export-jsx-to-pdf-stage"]
    }
    backend = {
      machine_type    = "t3.micro"
      network_ip      = "10.20.10.140"
      additional_tags = ["Name=agalias-diploma/export-jsx-to-pdf-stage"]
    }
  }

  # VPC specific settings
  subnet            = module.vpc.public_subnets[0] # Use the first public subnet
  security_group_id = aws_security_group.ec2_sg.id
  iam_role_name     = var.iam_role_name
}

module "firewall" {
  source = "../../modules/firewall"
  
  network = local.env
  vpc_id  = module.vpc.vpc_id
  env     = local.env
  region  = var.region  # Add this line
  
  ingress_rules = var.ingress_rules
}

resource "aws_eip" "nat" {
  domain = "vpc"
}
