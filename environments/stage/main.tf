locals {
  env                  = "stage"
  frontend_service_tag = "frontend"
  backend_service_tag  = "backend"
  domain_name          = "agalias-project.online"
}

module "vpc" {
  source = "../../modules/vpc"

  env    = local.env
  region = var.region
  azs    = ["eu-north-1a"]

  additional_tags = {
    Environment = local.env
  }
}

# Create EC2 instances in the VPC with security group and subnet references
module "ec2" {
  source = "../../modules/ec2"
  env    = local.env

  instances = {
    frontend = {
      machine_type = "t3.micro"
      network_ip   = "10.20.10.135"
      additional_tags = {
        Name    = "stage-frontend",
        Project = "agalias-diploma",
        service = local.frontend_service_tag,
        Domain  = "stage.${local.domain_name}"
      }
    }
    backend = {
      machine_type = "t3.micro"
      network_ip   = "10.20.10.140"
      additional_tags = {
        Name    = "stage-backend",
        Project = "agalias-diploma",
        service = local.backend_service_tag,
        Domain  = "api-stage.${local.domain_name}"
      }
    }
  }

  # VPC specific settings
  subnet            = module.vpc.public_subnets[0] # Use the first public subnet
  security_group_id = module.firewall.security_group_id
  iam_role_name     = var.iam_role_name
}

module "firewall" {
  source = "../../modules/firewall"

  env    = local.env
  vpc_id = module.vpc.vpc_id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

data "aws_route53_zone" "main" {
  name         = local.domain_name
  private_zone = false
}

resource "aws_route53_record" "backend" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "api-stage.${local.domain_name}"
  type    = "A"
  ttl     = "60"
  records = [module.ec2.instance_public_ips["backend"]]
}

resource "aws_route53_record" "frontend" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "stage.${local.domain_name}"
  type    = "A"
  ttl     = "60"
  records = [module.ec2.instance_public_ips["frontend"]]
}
