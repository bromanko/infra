# Google Container Registry Writer Service Account Module

This module creates a service account that can read and write from a
Google Container Registry.

## Usage

```hcl-terraform
module "gcr-rw" {
  source         = "../../terraform/modules/gcr_writer"
  gcr_project_id = data.terraform_remote_state.images.outputs.project_id
  project_id     = local.project_id
  account_id     = "my-project-gcr-rw"
}
```
