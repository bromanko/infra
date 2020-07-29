locals {
  bucket_name = "artifacts.${var.gcr_project_id}.appspot.com"
}

resource "google_service_account" "ro" {
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.account_display_name
}

# storage.objectViewer enables an entity to docker pull from the repository
resource "google_storage_bucket_iam_member" "object_viewer" {
  bucket = local.bucket_name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.ro.email}"
}

resource "google_service_account_key" "ro_key" {
  service_account_id = google_service_account.ro.account_id
}
