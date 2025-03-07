output "instance_public_ips" {
  description = "Public IPs of the EC2 instances"
  value = {
    for instance_key, instance in aws_instance.service_instances :
    instance_key => instance.public_ip
  }
}

output "instance_private_ips" {
  description = "Private IPs of the EC2 instances"
  value = {
    for instance_key, instance in aws_instance.service_instances :
    instance_key => instance.private_ip
  }
}
