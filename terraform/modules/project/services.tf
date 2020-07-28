locals {
  additional_services = { for service in var.additional_services : service["service"] => service }
}

resource "google_project_service" "additional_service" {
  for_each                   = local.additional_services
  project                    = google_project.project.project_id
  service                    = each.value["service"]
  disable_dependent_services = each.value["disable_dependent_services"]
  disable_on_destroy         = each.value["disable_on_destroy"]
}
