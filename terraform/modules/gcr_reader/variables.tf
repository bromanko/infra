variable "gcr_project_id" {
  type = string
}

variable "account_id" {
  type = string
}

variable "account_display_name" {
  type    = string
  default = "GCR read-only service account"
}
