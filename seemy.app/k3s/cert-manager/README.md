# Cert Manager Installation

cert-manager has been installing using Helm following [these instructions](https://hub.helm.sh/charts/jetstack/cert-manager).

The CRDs have been downloaded and stored in this repository at `cert-manager-crds.yaml`.

## CloudFlare DNS01 Solver

A CloudFlare DNS solver is configured with an API token. The API
token was manually created as a secret following [these instructions](https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/).

