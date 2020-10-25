resource "google_storage_bucket" "data" {
  project_id = module.project.project_id
  name = "trenton-production-data"
  force_destroy = true
}

