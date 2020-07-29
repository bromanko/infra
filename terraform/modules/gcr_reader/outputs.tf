output "service_account_key" {
  value     = google_service_account_key.ro_key
  sensitive = true
}
