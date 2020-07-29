resource "google_service_account" "ci" {
  account_id   = "ci-pipeline"
  display_name = "CI Pipeline Account"
  project      = module.project.project_id
}

resource "google_service_account_key" "ci_account_key" {
  service_account_id = google_service_account.ci.account_id
}
