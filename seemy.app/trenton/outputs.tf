output "k3s_service_account_key" {
  value     = google_service_account_key.k3s_key.private_key
  sensitive = true
}

output "ci_service_account_key" {
  value     = google_service_account_key.ci_account_key.private_key
  sensitive = true
}

output "web_service_account_key" {
  value     = google_service_account_key.production_web_server.private_key
  sensitive = true
}

output "webhooks_service_account_key" {
  value     = google_service_account_key.production_webhooks_server.private_key
  sensitive = true
}

output "ci_testing_service_account_key" {
  value     = google_service_account_key.ci_testing.private_key
  sensitive = true
}
