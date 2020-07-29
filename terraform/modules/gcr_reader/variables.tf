variable "gcr_project_id" {
  type        = string
  description = "Project ID for the project containing GCR"
}

variable "project_id" {
  default = "Project ID for the project to create the service account"
}

variable "account_id" {
  type = string
}

variable "account_display_name" {
  type    = string
  default = "GCR read-only service account"
}
