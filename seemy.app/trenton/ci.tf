resource "google_service_account" "ci" {
  provider     = google
  account_id   = "ci-pipeline"
  display_name = "CI Pipeline Account"
  project      = module.project.project_id
}

resource "google_service_account_key" "ci_account_key" {
  provider           = google
  service_account_id = google_service_account.ci.name
}
