resource "google_project_service" "datastore" {
  provider                   = google
  project                    = module.project.project_id
  disable_dependent_services = false
  disable_on_destroy         = false
  service                    = "datastore.googleapis.com"
}
