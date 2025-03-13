resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = {
    Name        = "agalias-project-dns"
    Project     = "agalias-diploma"
    Environment = "all"
  }
}
