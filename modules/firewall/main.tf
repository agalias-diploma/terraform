resource "aws_security_group" "ec2_sg" {
  name        = "${var.env}-ec2-sg"
  description = "Security group for EC2 instances in ${var.env}"
  vpc_id      = var.vpc_id

  # Ingress rules will be added dynamically
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.env}-ec2-sg"
    Environment = var.env
    Project     = "agalias-diploma"
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  for_each = var.ingress_rules

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  security_group_id = aws_security_group.ec2_sg.id
}
