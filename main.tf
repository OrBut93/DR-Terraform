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

# Create VPC peering between backup and network
resource "google_compute_network_peering" "backup_to_network" {
  provider        = google
  name            = "backup-to-network"
  network         = "backup-vpc"
  peer_network    = "projects/<network_project_id>/global/networks/network-vpc"
  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "network_to_backup" {
  provider        = google.network
  name            = "network-to-backup"
  network         = "network-vpc"
  peer_network    = "projects/<backup_project_id>/global/networks/backup-vpc"
  export_custom_routes = true
  import_custom_routes = true
}

# Create VPC peering between network and production
resource "google_compute_network_peering" "network_to_production" {
  provider        = google.network
  name            = "network-to-production"
  network         = "network-vpc"
  peer_network    = "projects/<production_project_id>/global/networks/production-vpc"
  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "production_to_network" {
  provider        = google.production
  name            = "production-to-network"
  network         = "production-vpc"
  peer_network    = "projects/<network_project_id>/global/networks/network-vpc"
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
