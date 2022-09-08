terraform {
  required_version = ">= 1.0.0"
}

# Default configuration for the google provider.
provider "google" {
  region = local.location
}

# Local variables
locals {
    project_name        = ""        # TODO: Name your project Max 25 ccrs
    location            = ""        # TODO: Example: europe-west1
    zone                = ""        # TODO: Example: europe-west1-b
    repo                = ""        # TODO: Name of github repo, if in org, use <org/repo>
    billing_account     = ""        # TODO: Billing account for the GCP Project
}

module "project" {
  project_name          = local.project_name
  billing_account       = local.billing_account
  source                = "./modules/project"
}


module "compute_engine" {
    zone        = local.zone
    project_id     = module.project.project_id
    network         = module.project.default_network
    source               = "./modules/compute_instance"
    depends_on = [
    module.project
  ]
}

module "wip-github" {
  project_id          = module.project.project_id
  repo = local.repo
  source                = "./modules/wip-github"
    depends_on = [
    module.project
  ]
}

output "project_id" {
  value = module.project.project_id
}

output "provider_id" {
  value = module.wip-github.provider_id
}

output "service_account" {
  value = module.wip-github.service_account
}