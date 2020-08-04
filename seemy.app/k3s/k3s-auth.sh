#!/usr/bin/env bash

set -e

K8S_OICD_CLIENT_ID="302508247932-5usfekhtdbkq4gkup22kraqbqq70gubt.apps.googleusercontent.com"
[ -z "$K8S_OIDC_CLIENT_SECRET" ] && (echo "K8S_OIDC_CLIENT_SECRET env variable must be set."; exit 1)

docker run --rm -it \
  -v "$HOME/.kube:/etc/kube" \
  micahhausler/k8s-oidc-helper \
  --client-id "${K8S_OICD_CLIENT_ID}" \
  --client-secret "${K8S_OIDC_CLIENT_SECRET}" \
  -o \
  -w --file /etc/kube/seemy.app.yaml
