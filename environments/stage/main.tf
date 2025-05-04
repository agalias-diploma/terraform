locals {
  env                  = "stage"
  frontend_service_tag = "frontend"
  backend_service_tag  = "backend"
  domain_name          = "agalias-project.online"
}

module "vpc" {
  source = "../../modules/vpc"

  env    = local.env
  region = var.region
  azs    = ["eu-north-1a"]

  additional_tags = {
    Environment = local.env
  }
}

# Create EC2 instances in the VPC with security group and subnet references
module "ec2" {
  source = "../../modules/ec2"
  env    = local.env

  instances = {
    frontend = {
      machine_type = "t3.micro"
      network_ip   = "10.20.10.135"
      additional_tags = {
        Name    = "stage-frontend",
        Project = "agalias-diploma",
        service = local.frontend_service_tag,
        Domain  = "stage.${local.domain_name}"
      }
    }
    backend = {
      machine_type = "t3.micro"
      network_ip   = "10.20.10.140"
      additional_tags = {
        Name    = "stage-backend",
        Project = "agalias-diploma",
        service = local.backend_service_tag,
        Domain  = "api-stage.${local.domain_name}"
      }
    }
  }

  # VPC specific settings
  subnet            = module.vpc.public_subnets[0] # Use the first public subnet
  security_group_id = module.firewall.security_group_id
  iam_role_name     = var.iam_role_name
}

module "firewall" {
  source = "../../modules/firewall"

  env    = local.env
  vpc_id = module.vpc.vpc_id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

data "aws_route53_zone" "main" {
  name         = local.domain_name
  private_zone = false
}

resource "aws_route53_record" "backend" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "api-stage.${local.domain_name}"
  type    = "A"
  ttl     = "60"
  records = [module.ec2.instance_public_ips["backend"]]
}

resource "aws_route53_record" "frontend" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "stage.${local.domain_name}"
  type    = "A"
  ttl     = "60"
  records = [module.ec2.instance_public_ips["frontend"]]
}

####### THIS IS NOT THE BEST WAY TO DO THIS, BUT IT WORKS GOOD AND RUN SCRIPTS #######
### Automate deployment of backend and frontend applications to EC2 instances ###
# Create "wait for cloud-init" resources
resource "null_resource" "wait_for_backend" {
  depends_on = [module.ec2, aws_route53_record.backend]

  provisioner "local-exec" {
    command = <<-EOT
      # Wait for SSH to be available
      until ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -i ${var.ssh_private_key_path} ubuntu@${module.ec2.instance_public_ips["backend"]} echo 'SSH ready'; do
        echo 'Waiting for SSH to be available...'
        sleep 10
      done
      
      # Allow cloud-init to complete
      ssh -o StrictHostKeyChecking=no -i ${var.ssh_private_key_path} ubuntu@${module.ec2.instance_public_ips["backend"]} 'cloud-init status --wait'
    EOT
  }
}

resource "null_resource" "wait_for_frontend" {
  depends_on = [module.ec2, aws_route53_record.frontend]

  provisioner "local-exec" {
    command = <<-EOT
      # Wait for SSH to be available
      until ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -i ${var.ssh_private_key_path} ubuntu@${module.ec2.instance_public_ips["frontend"]} echo 'SSH ready'; do
        echo 'Waiting for SSH to be available...'
        sleep 10
      done
      
      # Allow cloud-init to complete
      ssh -o StrictHostKeyChecking=no -i ${var.ssh_private_key_path} ubuntu@${module.ec2.instance_public_ips["frontend"]} 'cloud-init status --wait'
    EOT
  }
}

# Deploy to backend instance
resource "null_resource" "deploy_backend" {
  depends_on = [null_resource.wait_for_backend]

  triggers = {
    instance_ip = module.ec2.instance_public_ips["backend"]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.ssh_private_key_path)
    host        = module.ec2.instance_public_ips["backend"]
  }

  # First, prepare the instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install -y git",
      "sudo git clone https://github.com/agalias-diploma/backend.git /home/ubuntu/backend",
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/backend",
      "sudo chmod -R 755 /home/ubuntu/backend"
    ]
  }

  # Execute deployment
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/backend/deploy-backend-ec2.sh",
      "chmod +x /home/ubuntu/backend/entrypoint-stage.sh",
      "sudo /home/ubuntu/backend/deploy-backend-ec2.sh"
    ]
  }
}

# Deploy to frontend instance
resource "null_resource" "deploy_frontend" {
  depends_on = [null_resource.wait_for_frontend]

  triggers = {
    instance_ip = module.ec2.instance_public_ips["frontend"]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.ssh_private_key_path)
    host        = module.ec2.instance_public_ips["frontend"]
  }

  # First, prepare the instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install -y git",  
      "sudo git clone https://github.com/agalias-diploma/export-jsx-to-pdf /home/ubuntu/frontend",
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/frontend",
      "sudo chmod -R 755 /home/ubuntu/frontend"
    ]
  }

  # Execute deployment
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/frontend/deploy-frontend-ec2.sh",
      "sudo /home/ubuntu/frontend/deploy-frontend-ec2.sh"
    ]
  }
}
