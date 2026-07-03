$ErrorActionPreference = "Stop"

$CatalogRef = $env:DOCKYARD_CATALOG_PUBLISH_REF
if ([string]::IsNullOrWhiteSpace($CatalogRef)) {
  $CatalogRef = "ghcr.io/nandub/dockyard-packages/catalog:latest"
}
$CatalogRef = $CatalogRef -replace '^oci://', ''

if (-not (Test-Path ".\catalog.yaml")) {
  throw "catalog.yaml not found. Run this script from the repository root."
}

oras push --artifact-type application/vnd.dockyard.catalog.v1+yaml $CatalogRef "catalog.yaml:application/vnd.dockyard.catalog.index.v1+yaml"
