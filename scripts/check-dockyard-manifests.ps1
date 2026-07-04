$ErrorActionPreference = "Stop"

$bad = Select-String -Path ".\packages\*\Dockyard.yaml" -Pattern "^kind:|^metadata:|^\s+name:" -ErrorAction SilentlyContinue

if ($bad) {
  $bad | ForEach-Object { Write-Error "$($_.Path):$($_.LineNumber): $($_.Line)" }
  throw "Invalid Dockyard manifest shape found. Use flat apiVersion/name/version fields only."
}

Write-Host "Dockyard manifests OK: flat Dockyard format only."
