resource "google_storage_bucket" "production_data" {
  project       = module.project.project_id
  name          = "data.trenton.seemy.app"
  force_destroy = true
  storage_class = "STANDARD"
  location      = "US-CENTRAL1"
}

resource "google_storage_bucket_iam_member" "production_data_webhooks" {
  bucket = google_storage_bucket.production_data.name
  member = "serviceAccount:${google_service_account.production_webhooks_server.email}"
  role   = "roles/storage.objectAdmin"
}

resource "google_storage_bucket" "test_data" {
  project       = module.project.project_id
  name          = "test.data.trenton.seemy.app"
  storage_class = "STANDARD"
  location      = "US-CENTRAL1"
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

resource "google_storage_bucket_iam_member" "test_data_ci" {
  bucket = google_storage_bucket.test_data.name
  member = "serviceAccount:${google_service_account.ci.email}"
  role   = "roles/storage.objectCreator"
}
