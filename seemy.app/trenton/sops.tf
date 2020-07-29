module "sops" {
  source     = "../terraform/modules/sops"
  project_id = module.project.project_id
}

resource "google_kms_crypto_key_iam_member" "ci_account_sops" {
  crypto_key_id = module.sops.sops_kms_crypto_key_id
  member        = "serviceAccount:${google_service_account.ci.email}"
  role          = "roles/cloudkms.cryptoKeyDecrypter"
}
