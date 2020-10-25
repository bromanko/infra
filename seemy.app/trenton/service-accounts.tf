resource "google_service_account" "k3s" {
  provider     = google
  project      = module.project.project_id
  account_id   = "trenton-k3s-reader"
  display_name = "Service account used for pulling Docker images in k3s"
}

resource "google_service_account_key" "k3s_key" {
  provider           = google
  service_account_id = google_service_account.k3s.name
}

resource "google_artifact_registry_repository_iam_member" "k3s" {
  provider   = google-beta
  project    = module.project.project_id
  location   = google_artifact_registry_repository.artifact_repository.location
  repository = google_artifact_registry_repository.artifact_repository.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.k3s.email}"
}

resource "google_artifact_registry_repository_iam_member" "ci" {
  provider   = google-beta
  project    = module.project.project_id
  location   = google_artifact_registry_repository.artifact_repository.location
  repository = google_artifact_registry_repository.artifact_repository.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.ci.email}"
}

resource "google_service_account" "production_web_server" {
  provider     = google-beta
  project      = module.project.project_id
  account_id   = "web-server"
  display_name = "Service account for the web server app"
}

resource "google_service_account_key" "production_web_server" {
  provider           = google
  service_account_id = google_service_account.production_web_server.name
}

resource "google_project_iam_member" "production_web_server" {
  provider = google
  project = module.project.project_id
  member = "serviceAccount:${google_service_account.production_web_server.email}"
  role = "roles/datastore.user"
}

resource "google_service_account" "production_webhooks_server" {
  provider     = google-beta
  project      = module.project.project_id
  account_id   = "webhooks-server"
  display_name = "Service account for the webhooks server app"
}

resource "google_service_account_key" "production_webhooks_server" {
  provider           = google
  service_account_id = google_service_account.production_webhooks_server.name
}
