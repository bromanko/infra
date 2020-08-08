resource "google_project_service" "artifact_repository" {
  provider                   = google
  project                    = module.project.project_id
  disable_dependent_services = false
  disable_on_destroy         = false
  service                    = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "artifact_repository" {
  provider      = google-beta
  depends_on    = [google_project_service.artifact_repository]
  project       = module.project.project_id
  location      = "us-central1"
  repository_id = "trenton"
  format        = "DOCKER"
}

