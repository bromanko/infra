output "gcr_rw_service_account_key" {
  value     = module.gcr-rw.service_account_key
  sensitive = true
}
