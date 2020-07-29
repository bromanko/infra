terraform {
  backend "remote" {
    organization = "bromanko"

    workspaces {
      name = "trenton"
    }
  }
}

provider "google" {
  version     = "~> 2.17.0"
  credentials = var.gcp_credentials
}

resource "google_folder" "trenton" {
  display_name = var.project_name
  parent       = var.folder_id
}

module "project" {
  source             = "../terraform/modules/project"
  billing_account_id = var.billing_account_id
  folder_id          = google_folder.trenton.id
  project_name       = "${var.project_name} Production"
  additional_services = [{
    service                    = "cloudkms.googleapis.com"
    disable_dependent_services = false
    disable_on_destroy         = false
  }]
}

module "gcr-rw" {
  source         = "../terraform/modules/gcr_writer"
  gcr_project_id = module.project.project_id
  account_id     = "trenton-gcr-rw"
}

# TODO Sops configuration
