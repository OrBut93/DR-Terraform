# configure backup project  
provider "google" {
  credentials = file(var.backup_service_account_key_path)
  project     = "<backup_project_id>"
  region      = var.region
}

# configure network project  
provider "google" {
  alias       = "network"
  credentials = file(var.network_service_account_key_path)
  project     = "<network_project_id>"
  region      = var.region
}
# configure production project  
provider "google" {
  alias       = "production"
  credentials = file(var.production_service_account_key_path)
  project     = "<production_project_id>"
  region      = var.region
}

###############################################
# CREATE VPC
###############################################

resource "google_compute_network" "vpc_backup" {
  name                    = "vpc-backup"
  project                 = "<backup_project_id>"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  project                 = "<network_project_id>"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc_production" {
  name                    = "vpc-production"
  project                 = "<production_project_id>"
  auto_create_subnetworks = false
}


###############################################
# PEERINGS
###############################################

# Create VPC peering between backup and network

resource "google_compute_network_peering" "backup_to_network" {
  provider        = google
  name            = "backup-to-network"
  network         = "vpc_backup"
  peer_network    = "projects/"+var.network_project_id+"/global/networks/vpc_network"
  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "network_to_backup" {
  provider        = google.network
  name            = "network-to-backup"
  network         = "vpc_network"
  peer_network    = "projects/"+var.backup_project_id+"/global/networks/vpc_backup"
  export_custom_routes = true
  import_custom_routes = true
}

# Create VPC peering between network and production
resource "google_compute_network_peering" "network_to_production" {
  provider        = google.network
  name            = "network-to-production"
  network         = "vpc_network"
  peer_network    = "projects/"+var.production_project_id+"/global/networks/vpc_production"
  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "production_to_network" {
  provider        = google.production
  name            = "production-to-network"
  network         = "vpc_production"
  peer_network    = "projects/"+var.network_project_id+"/global/networks/vpc_network"
  export_custom_routes = true
  import_custom_routes = true
}

# Output Peering Information
output "backup_to_network_status" {
  value = google_compute_network_peering.backup_to_network.state
}

output "network_to_backup_status" {
  value = google_compute_network_peering.network_to_backup.state
}

output "network_to_production_status" {
  value = google_compute_network_peering.network_to_production.state
}

output "production_to_network_status" {
  value = google_compute_network_peering.production_to_network.state
}
