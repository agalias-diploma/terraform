locals {
  network = element(split("-", var.subnet), 0)
}

resource "aws_instance" "service_instances" {
  for_each = var.instances

  ami           = var.ami
  instance_type = each.value.machine_type
  subnet_id     = var.subnet
  key_name      = var.ssh-key

  vpc_security_group_ids = [var.security_group_id]
  private_ip             = each.value.network_ip

  associate_public_ip_address = true

  # IAM Role for AWS Instances
  iam_instance_profile = var.iam_role_name

  tags = merge(
    {
      Name    = "${var.env}-${each.key}"
      Project = "agalias-diploma"
      Environment = var.env
      Service = each.key
    },
    each.value.additional_tags
  )
}
