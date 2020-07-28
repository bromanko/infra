variable "billing_account_id" {
  type        = string
  description = "ID of billing account"
}

variable "folder_id" {
  type        = string
  description = "ID of GCP folder this project resides in"
}

variable "project_name" {
  type = string
}

variable "skip_delete" {
  default     = true
  description = "Prevent project from accidental deletion"
}

variable "additional_services" {
  default     = []
  description = "Additional services to add to this project"
  type = list(object({
    service                    = string
    disable_dependent_services = bool
    disable_on_destroy         = bool
  }))
}
