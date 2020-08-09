terraform {
  backend "remote" {
    organization = "bromanko"

    workspaces {
      name = "trenton"
    }
  }
}

provider "google" {
  version     = "~> 3.32.0"
  credentials = var.gcp_credentials
}

provider "google-beta" {
  version     = "~> 3.32.0"
  credentials = var.gcp_credentials
}

