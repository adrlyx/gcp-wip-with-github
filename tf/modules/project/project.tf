# GCP APIs to enable
locals {
    services = [
      "sts.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "compute.googleapis.com",
      "secretmanager.googleapis.com",
      "iamcredentials.googleapis.com",
      "iam.googleapis.com"
  ]
}

# Create a random string for the project-id
resource "random_string" "project_suffix" {
  length  = 4
  special = false
  upper   = false
}

# Create a GCP project. 
resource "google_project" "project" {
  name       = var.project_name
  project_id = "${var.project_name}-${random_string.project_suffix.result}"
  billing_account     = var.billing_account
  auto_create_network = false
}

# Enable APIs
resource "google_project_service" "services" {
  for_each = toset(local.services)
  project                    = "${google_project.project.project_id}"
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
  depends_on = [google_project.project]
}

# Create a default network
resource "google_compute_network" "vpc_network" {
  project = google_project.project.project_id
  name                    = "default"
  auto_create_subnetworks = "true"
}

output "project_id" {
  value       = google_project.project.project_id
  description = "The ID of the project"
}

output "default_network" {
  value       = google_compute_network.vpc_network.name
  description = "The name of the default network"
}
