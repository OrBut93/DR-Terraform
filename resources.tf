resource "google_compute_network" "vpc-restore" {
  name = "vpc-restore"
   auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet-restore" {
  name          = "subnet-restore"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west3"
  network       = google_compute_network.vpc-restore.name
  
}


resource "google_compute_instance" "vm-restore" {

  name         = "vm-restore"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240516"
    }

  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet-restore.id
    access_config {}
}
}

# Establish VPC peering from restore project VPC to the network project VPC in the other project
resource "google_compute_network_peering" "peering_to_network_project" {
  name          = "vpc-restore-to-network-project-vpc"
  network       = google_compute_network.vpc-restore.name
  peer_network  = "projects/network-project-id/global/networks/network-project-vpc-name"
  export_custom_routes = true
  import_custom_routes = true

}

# Provide the peering request acceptance in the network project
resource "google_compute_network_peering" "network_project_vpc_to_vpc_restore" {
  provider      = google.existing_project
  name          = "vpc-restore-to-network-project-vpc"
  network       = "projects/network-project-id/global/networks/network-project-vpc-name"
  peer_network  = "projects/orprojectestt/global/networks/vpc-restore"
  auto_create_routes = true
}
