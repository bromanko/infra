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


