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
