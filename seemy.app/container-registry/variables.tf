variable "gcp_credentials" {
  type        = string
  description = "JSON string containing Service Account credentials for Terraform executor"
}

variable "billing_account_id" {
  type        = string
  description = "ID of billing account for the project"
}

variable "folder_id" {
  type        = string
  description = "ID of GCP folder the GCR project should reside within"
}

variable "project_name" {
  type    = string
  default = "See My App GCR"
}
