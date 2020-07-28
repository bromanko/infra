locals {
  default_services = [
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "iam.googleapis.com",
    "stackdriver.googleapis.com",
    "logging.googleapis.com"
  ]
}

resource "random_id" "id" {
  byte_length = 4
  prefix      = var.project_name
}


resource "google_project" "project" {
  name            = var.project_name
  project_id      = random_id.id.hex
  folder_id       = var.folder_id
  billing_account = var.billing_account_id

  auto_create_network = false
  skip_delete         = var.skip_delete
}

resource "google_project_service" "service" {
  for_each = toset(local.default_services)
  service  = each.key
  project  = google_project.project.project_id
}

