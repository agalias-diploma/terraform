module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.env}-vpc"
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  enable_vpn_gateway   = false

  tags = merge(
    {
      Name        = "${var.env}-vpc"
      Environment = var.env
      Project     = "agalias-diploma"
      Terraform   = "true"
    },
    var.additional_tags
  )
}
