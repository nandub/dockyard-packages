param(
  [Parameter(Mandatory = $true)]
  [string]$Package,

  [string]$Version,

  [string]$Registry = "ghcr.io/nandub/dockyard-packages",

  [switch]$PublishCatalog,

  [string]$CatalogRef = "ghcr.io/nandub/dockyard-packages/catalog:latest"
)

$ErrorActionPreference = "Stop"

function Read-PackageVersion {
  param([string]$ManifestPath)

  if (-not (Test-Path $ManifestPath)) {
    throw "Dockyard package manifest not found: $ManifestPath"
  }

  $versionLine = Select-String -Path $ManifestPath -Pattern '^\s*version:\s*(.+?)\s*$' | Select-Object -First 1
  if (-not $versionLine) {
    throw "could not find version in $ManifestPath; pass -Version explicitly"
  }

  return $versionLine.Matches[0].Groups[1].Value.Trim().Trim('"').Trim("'")
}

$packageDir = Join-Path "packages" $Package
if (-not (Test-Path $packageDir)) {
  throw "package directory not found: $packageDir"
}

if (-not $Version) {
  $Version = Read-PackageVersion (Join-Path $packageDir "Dockyard.yaml")
}

New-Item -ItemType Directory -Force "dist" | Out-Null

$archive = Join-Path "dist" "$Package-$Version.dockyard.tgz"
$ref = "oci://$Registry/$Package`:$Version"

Remove-Item $archive -ErrorAction SilentlyContinue

Write-Host "==> lint $Package@$Version"
dockyard package lint $packageDir --strict

Write-Host "==> test $Package@$Version"
dockyard package test $packageDir --strict

Write-Host "==> package $Package@$Version"
dockyard package $packageDir -o $archive

Write-Host "==> push $ref"
dockyard push $archive $ref

if ($PublishCatalog) {
  if (-not (Test-Path "catalog.yaml")) {
    throw "catalog.yaml not found; cannot publish catalog index"
  }

  $oras = Get-Command oras -ErrorAction SilentlyContinue
  if (-not $oras) {
    throw "oras is required to publish the catalog index"
  }

  Write-Host "==> publish catalog oci://$CatalogRef"
  oras push $CatalogRef "catalog.yaml:application/vnd.dockyard.catalog.v1+yaml" `
    --artifact-type "application/vnd.dockyard.catalog.v1+yaml"
}

Write-Host "published $Package@$Version to $ref"
