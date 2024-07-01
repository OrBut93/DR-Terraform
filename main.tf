terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "orprojectestt"
  region  = "var.region"
}

# Provider for the network project
provider "google" {
  alias       = "network_project"
  credentials = file("<path-to-existing-project-service-account-key>.json")
  project     = "network-project-id"
  region      = "us-central1"
}

