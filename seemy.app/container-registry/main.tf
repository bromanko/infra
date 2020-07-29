terraform {
  backend "remote" {
    organization = "bromanko"

    workspaces {
      name = "container-registry"
    }
  }
}

provider "google" {
  version     = "~> 3.32.0"
  credentials = var.gcp_credentials
}

module "gcr-project" {
  source             = "../terraform/modules/project"
  project_name       = var.project_name
  folder_id          = var.folder_id
  billing_account_id = var.billing_account_id
  additional_services = [
    {
      service                    = "containerregistry.googleapis.com"
      disable_dependent_services = false
      disable_on_destroy         = false
    },
    {
      service                    = "storage-api.googleapis.com"
      disable_dependent_services = false
      disable_on_destroy         = false
    }
  ]
}



data "google_container_registry_repository" "main" {
  project = module.gcr-project.project_id
}


