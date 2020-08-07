resource "google_project_service" "datastore" {
  disable_dependent_services = false
  disable_on_destroy = false
  service = "datastore.googleapis.com"
}
