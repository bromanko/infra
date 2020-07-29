locals {
  bucket_name = "artifacts.${var.gcr_project_id}.appspot.com"
}

resource "google_service_account" "rw" {
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.account_display_name
}

# storage.objectAdmin provides complete access to objects in a bucket, but no
# access to the bucket itself. This is one of two roles required to grant
# docker push access
resource "google_storage_bucket_iam_member" "object_admin" {
  bucket = local.bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.rw.email}"
}

# docker push also requires storage.buckets.get in order to work properly
# storage.legacyBucketReader is the least permissive role that provides this
resource "google_storage_bucket_iam_member" "legacy_bucket_reader" {
  bucket = local.bucket_name
  role   = "roles/storage.legacyBucketReader"
  member = "serviceAccount:${google_service_account.rw.email}"
}

resource "google_service_account_key" "rw_key" {
  project            = var.project_id
  service_account_id = google_service_account.rw.account_id
}
