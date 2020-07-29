resource "google_project_service" "cloudkms" {
  project = var.project_id
  service = "cloudkms.googleapis.com"
}

resource "random_id" "keyring" {
  byte_length = 8
  keepers = {
    project = var.project_id
  }
  prefix = "sops-"
}

resource "google_kms_key_ring" "sops" {
  depends_on = [google_project_service.cloudkms]
  project    = random_id.keyring.keepers.project
  location   = "global"
  name       = random_id.keyring.hex
}

resource "google_kms_crypto_key" "sops" {
  name     = "sops-key"
  key_ring = google_kms_key_ring.sops.id
  purpose  = "ENCRYPT_DECRYPT"
}
