resource "google_storage_bucket" "production_data" {
  project       = module.project.project_id
  name          = "trenton-production-data"
  force_destroy = true
}

resource "google_storage_bucket_access_control" "production_data_webhooks" {
  bucket = google_storage_bucket.production_data.name
  entity = "serviceAccount:${google_service_account.production_webhooks_server.email}"
  role   = "OWNER"
}
