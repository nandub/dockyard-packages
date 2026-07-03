$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force .\dist | Out-Null
Remove-Item .\dist\redis-0.2.0.dockyard.tgz -ErrorAction SilentlyContinue

dockyard package .\packages\redis -o .\dist\redis-0.2.0.dockyard.tgz
dockyard push .\dist\redis-0.2.0.dockyard.tgz "oci://ghcr.io/nandub/dockyard-packages/redis:0.2.0"

.\scripts\publish-catalog.ps1
