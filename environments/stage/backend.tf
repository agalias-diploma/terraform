terraform {
  backend "s3" {
    bucket         = "agalias-terraform-state-files"
    profile        = "agalias-personal"
    region         = "eu-north-1"
    key            = "stage/terraform.tfstate"
    dynamodb_table = "terraform-env-stage-state-lock"
    encrypt        = true
  }
}
