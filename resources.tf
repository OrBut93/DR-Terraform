resource "google_compute_network" "vpc_restore" {
  name = "vpc_restore"
}

resource "google_compute_subnetwork" "subnet_restore" {
  name          = "subnet_restore"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west3"
  network       = google_compute_network.vpc_restore
  
}
