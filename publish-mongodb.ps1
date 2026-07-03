New-Item -ItemType Directory -Force .\dist | Out-Null

dockyard package lint .\packages\mongodb --strict
dockyard package test .\packages\mongodb --strict

$archive = ".\dist\mongodb-0.1.0.dockyard.tgz"
Remove-Item $archive -ErrorAction SilentlyContinue

dockyard package .\packages\mongodb -o $archive
dockyard push $archive "oci://ghcr.io/nandub/dockyard-packages/mongodb:0.1.0"
dockyard package test "oci://ghcr.io/nandub/dockyard-packages/mongodb:0.1.0" --strict
