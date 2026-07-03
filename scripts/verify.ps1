$ErrorActionPreference = "Stop"

$dockyard = if ($env:DOCKYARD) { $env:DOCKYARD } else { "dockyard" }

if (-not (Test-Path ".\catalog.yaml")) {
    throw "catalog.yaml is required"
}

Get-ChildItem -Directory .\packages | ForEach-Object {
    Write-Host "==> $($_.FullName)"
    & $dockyard package lint $_.FullName --strict
    & $dockyard package test $_.FullName --strict
}
