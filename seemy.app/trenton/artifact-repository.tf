resource "google_artifact_registry_repository" "artifact_repository" {
  provider      = google-beta
  project       = module.project.project_id
  location      = "us-central1"
  repository_id = "trenton"
  format        = "DOCKER"
}

