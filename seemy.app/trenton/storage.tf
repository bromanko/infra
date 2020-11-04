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

resource "google_storage_bucket" "test_data" {
  project       = module.project.project_id
  name          = "trenton-test-data"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket_iam_member" "test_data_ci_testing" {
  bucket = google_storage_bucket.test_data.name
  member = "serviceAccount:${google_service_account.ci_testing.email}"
  role   = "roles/storage.objectCreator"
}
