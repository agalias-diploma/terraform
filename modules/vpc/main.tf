module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.env
  cidr = "10.20.10.0/24"

  azs             = var.region
  private_subnets = ["10.20.0.0/26", "10.20.0.64/26"]    # Example private subnets
  public_subnets  = ["10.20.0.128/26", "10.20.0.192/26"] # Example public subnets

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false
  enable_vpn_gateway   = false

  tags = {
    Name = "${var.env}-vpc"
    env  = var.env
  }
}
