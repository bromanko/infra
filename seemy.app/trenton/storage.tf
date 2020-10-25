resource "google_storage_bucket" "data" {
  name = "trenton-production-data"
  force_destroy = true
}

