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
