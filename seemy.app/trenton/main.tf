terraform {
  backend "remote" {
    organization = "bromanko"

    workspaces {
      name = "trenton"
    }
  }
}

data "terraform_remote_state" "images" {
  backend = "remote"

  config = {
    organization = "bromanko"
    workspaces = {
      name = "container-registry"
    }
  }
}

provider "google" {
  version     = "~> 3.32.0"
  credentials = var.gcp_credentials
}

resource "google_folder" "trenton" {
  display_name = var.project_name
  parent       = "folders/${var.folder_id}"
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
  gcr_project_id = data.terraform_remote_state.images.outputs.project_id
  project_id     = module.project.project_id
  account_id     = "trenton-gcr-rw"
}

# TODO Sops configuration
