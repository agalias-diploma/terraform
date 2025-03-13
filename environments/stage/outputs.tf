output "frontend_public_ip" {
  value = module.ec2.instance_public_ips["frontend"]
}

output "frontend_private_ip" {
  value = module.ec2.instance_private_ips["frontend"]
}

output "backend_public_ip" {
  value = module.ec2.instance_public_ips["backend"]
}

output "backend_private_ip" {
  value = module.ec2.instance_private_ips["backend"]
}

output "route53_zone_id" {
  value = data.aws_route53_zone.main.zone_id
}

output "backend_record" {
  value = {
    name    = aws_route53_record.backend.name
    records = aws_route53_record.backend.records
  }
}

output "instance_tags" {
  value = {
    frontend = module.ec2.instance_tags["frontend"]
    backend  = module.ec2.instance_tags["backend"]
  }
}

output "route53_records" {
  value = {
    frontend = aws_route53_record.frontend.fqdn
    backend  = aws_route53_record.backend.fqdn
  }
}

output "instance_details" {
  value = {
    frontend = {
      public_ip = module.ec2.instance_public_ips["frontend"]
      tags      = module.ec2.instance_tags["frontend"]
    }
    backend = {
      public_ip = module.ec2.instance_public_ips["backend"]
      tags      = module.ec2.instance_tags["backend"]
    }
  }
}

output "domains" {
  value = {
    frontend = "stage.${local.domain_name}"
    backend  = "api-stage.${local.domain_name}"
  }
}

output "dns_check" {
  value = {
    nameservers = data.aws_route53_zone.main.name_servers
    frontend_record = aws_route53_record.frontend.fqdn
    backend_record  = aws_route53_record.backend.fqdn
  }
}
