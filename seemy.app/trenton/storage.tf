resource "google_storage_bucket" "production_data" {
  project       = module.project.project_id
  name          = "trenton-production-data"
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "production_data_webhooks" {
  bucket = google_storage_bucket.production_data.name
  member = "serviceAccount:${google_service_account.production_webhooks_server.email}"
  role   = "roles/storage.objectCreator"
}
