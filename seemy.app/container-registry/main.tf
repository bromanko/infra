terraform {
  backend "remote" {
    organization = "bromanko"

    workspaces {
      name = "container-registry"
    }
  }
}

provider "google" {
  version     = "~> 2.17.0"
  credentials = var.gcp_credentials
}

module "gcr-project" {
  source             = "../terraform/modules/project"
  project_name       = var.project_name
  folder_id          = var.folder_id
  billing_account_id = var.billing_account_id
  additional_services = [
    {
      service                    = "containerregistry.googleapis.com"
      disable_dependent_services = false
      disable_on_destroy         = false
    },
    {
      service                    = "storage-api.googleapis.com"
      disable_dependent_services = false
      disable_on_destroy         = false
    }
  ]
}

locals {
  bucket_name = "artifacts.${module.gcr-project.project_id}.appspot.com"
  url         = data.google_container_registry_repository.main.repository_url
}

//resource "google_service_account" "rw" {
//  project      = var.project_id
//  account_id   = "gcr-read-write"
//  display_name = "GCR read/write service account"
//}
//
//resource "google_service_account" "ro" {
//  project      = var.project_id
//  account_id   = "gcr-read-only"
//  display_name = "GCR read-only service account"
//}

data "google_container_registry_repository" "main" {
  project = module.gcr-project.project_id
}


//# google_storage_bucket_iam_binding resources are authoritative for their respective roles
//# if an entity isn't in its list of members their access will be revoked
//
//# storage.objectAdmin provides complete access to objects in a bucket, but no access to the bucket itself
//# this is one of two roles required to grant docker push access
//resource "google_storage_bucket_iam_member" "object_admin" {
//  bucket = local.bucket_name
//  role   = "roles/storage.objectAdmin"
//  member = "serviceAccount:${google_service_account.rw.email}"
//}
//
//# docker push also requires storage.buckets.get in order to work properly
//# storage.legacyBucketReader is the least permissive role that provides this
//resource "google_storage_bucket_iam_member" "legacy_bucket_reader" {
//  bucket = local.bucket_name
//  role   = "roles/storage.legacyBucketReader"
//  member = "serviceAccount:${google_service_account.rw.email}"
//}
//
//# google_storage_bucket_iam_member resources are not authoritative for their roles
//# additional members can be configured outside this module
//
//# storage.objectViewer enables an entity to docker pull from the repository
//resource "google_storage_bucket_iam_member" "object_viewer" {
//  bucket = local.bucket_name
//  role   = "roles/storage.objectViewer"
//  member = "serviceAccount:${google_service_account.ro.email}"
//}
//
//resource "google_service_account_key" "ro_key" {
//  service_account_id = google_service_account.ro.account_id
//}
//
//resource "google_service_account_key" "rw_key" {
//  service_account_id = google_service_account.rw.account_id
//}
