# SOPS Key Module

This module creates resources to use SOPS within a project.

## Usage

```hcl-terraform
module "sops" {
  source         = "../../terraform/modules/sops"
  project_id     = local.project_id
}
```
