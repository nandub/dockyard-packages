#!/usr/bin/env bash
set -euo pipefail

catalog_ref="${DOCKYARD_CATALOG_PUBLISH_REF:-ghcr.io/nandub/dockyard-packages/catalog:latest}"
catalog_ref="${catalog_ref#oci://}"

if [[ ! -f catalog.yaml ]]; then
  echo "catalog.yaml not found. Run this script from the repository root." >&2
  exit 1
fi

oras push --artifact-type application/vnd.dockyard.catalog.v1+yaml "$catalog_ref" "catalog.yaml:application/vnd.dockyard.catalog.index.v1+yaml"
