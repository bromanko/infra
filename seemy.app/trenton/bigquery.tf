resource "google_project_service" "bigquery" {
  provider                   = google
  project                    = module.project.project_id
  disable_dependent_services = false
  disable_on_destroy         = false
  service                    = "bigquery.googleapis.com"
}

resource "google_bigquery_dataset" "health" {
  project    = module.project.project_id
  dataset_id = "health"
}
