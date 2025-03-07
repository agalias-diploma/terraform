output "network" {
  description = "The name of the VPC being created"
  value       = module.vpc.network_name
}

output "subnet" {
  description = "The names of the subnets being created"
  value       = element(module.vpc.subnets_names, 0)
}
