$ErrorActionPreference = "Stop"

$dockyard = if ($env:DOCKYARD) { $env:DOCKYARD } else { "dockyard" }

Get-ChildItem -Directory .\packages | ForEach-Object {
    Write-Host "==> $($_.FullName)"
    & $dockyard package lint $_.FullName --strict
    & $dockyard package test $_.FullName --strict
}
