# Create a security group for EC2 instances within the VPC
resource "aws_security_group" "ec2_sg" {
  name        = "${local.env}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = module.vpc.vpc_id # Reference the VPC ID from the module

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all inbound traffic (customize as needed)
  }

  # Allow internal traffic between EC2 instances
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block] # Allow traffic within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic (customize as needed)
  }

  tags = {
    Name = "${local.env}-ec2-sg"
  }
}


