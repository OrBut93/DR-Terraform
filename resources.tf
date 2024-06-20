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