# Project Module

This module standardizes how projects are created.

## Usage

```hcl-terraform
module "my-project" {
  source          = "../../terraform/modules/project"
  project_name    = "my-project"
  folder_id       = local.folder_id
  billing_account = local.billing_account
}
```
By default the project module enables several APIs:
- `cloudresourcemanager.googleapis.com`
- `cloudbilling.googleapis.com`
- `iam.googleapis.com`
- `stackdriver.googleapis.com`
- `logging.googleapis.com`

Additional services can be added by passing a list of maps to
`additional_services`.

```hcl-terraform
module "my-project" {
  source          = "../../terraform/modules/project"
  project_name    = "my-project"
  folder_id       = local.folder_id
  billing_account = local.billing_account

  additional_services = [
    {
      service                    = "bigquery-json.googleapis.com"
      disable_dependent_services = false
      disable_on_destroy         = false
    }
  ]
}
```
