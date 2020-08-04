module "gcr-rw" {
  source         = "../terraform/modules/gcr_writer"
  gcr_project_id = data.terraform_remote_state.images.outputs.project_id
  project_id     = module.project.project_id
  account_id     = "trenton-gcr-rw"
}

module "gcr-ro-k3s" {
  source         = "../terraform/modules/gcr_reader"
  gcr_project_id = data.terraform_remote_state.images.outputs.project_id
  project_id     = module.project.project_id
  account_id     = "trenton-gcr-ro-k3s"
}
