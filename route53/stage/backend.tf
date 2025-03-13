terraform {
  backend "s3" {
    bucket  = "agalias-terraform-state-files"
    profile = "agalias-personal"
    key     = "route53-stage/terraform.tfstate"
    region  = "eu-north-1"
  }
}
