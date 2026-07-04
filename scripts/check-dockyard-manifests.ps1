$ErrorActionPreference = "Stop"

$bad = Select-String -Path ".\packages\*\Dockyard.yaml" -Pattern "^kind:|^metadata:" -ErrorAction SilentlyContinue

if ($bad) {
  $bad | ForEach-Object {
    Write-Error "$($_.Path):$($_.LineNumber): invalid Kubernetes-style field '$($_.Line)'"
  }
  exit 1
}

Write-Host "Dockyard manifests OK: no kind/metadata fields found."
