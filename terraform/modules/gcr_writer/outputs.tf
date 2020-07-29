output "service_account_key" {
  value     = google_service_account_key.rw_key
  sensitive = true
}
