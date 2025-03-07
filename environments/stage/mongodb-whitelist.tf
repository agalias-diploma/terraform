# Add public IP of the backend instance to the MongoDB Atlas whitelist
resource "mongodbatlas_project_ip_access_list" "backend_ip" {
  project_id = var.mongodb_atlas_project_id
  ip_address = module.ec2.instance_public_ips["backend"]
  comment    = "Backend instance IP for ${local.env}"
}
