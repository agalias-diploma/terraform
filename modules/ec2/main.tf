locals {
  network = element(split("-", var.subnet), 0)
}

resource "aws_instance" "service_instances" {
  for_each = var.instances

  ami           = "ami-02e2af61198e99faf" # Free tier Ubuntu 22.04 64-bit (x86)
  instance_type = each.value.machine_type
  subnet_id     = var.subnet
  key_name      = "agalias-personal-ec2-instances-ssh"

  vpc_security_group_ids = [var.security_group_id]
  private_ip             = each.value.network_ip

  associate_public_ip_address = true

  # IAM Role for AWS Instances
  iam_instance_profile = var.iam_role_name

  tags = {
    Name = "${local.network}-${each.key}-agalias-diploma"
    app  = "agalias-diploma"
    env  = var.env
  }
}
