resource "aws_security_group" "ingress_rules" {
  name        = "${var.network}-security-group"
  description = "Security group for ${var.network}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.name
      from_port   = ingress.value.ports[0]
      to_port     = ingress.value.ports[0]
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.network}-security-group"
    env  = var.env
  }
}
