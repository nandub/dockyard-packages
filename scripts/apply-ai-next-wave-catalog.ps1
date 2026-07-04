param(
  [string]$CatalogPath = ".\catalog.yaml"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $CatalogPath)) {
  throw "catalog.yaml not found at $CatalogPath"
}

$entries = [ordered]@{
  "anythingllm" = [ordered]@{
    latest = "0.1.0"
    description = "Self-hosted AI workspace for document chat and retrieval-augmented generation."
    source = "oci://ghcr.io/nandub/dockyard-packages/anythingllm"
    versions = @("0.1.0")
  }
  "flowise" = [ordered]@{
    latest = "0.1.0"
    description = "Visual LLM workflow builder for chatbots, agents, and RAG pipelines."
    source = "oci://ghcr.io/nandub/dockyard-packages/flowise"
    versions = @("0.1.0")
  }
  "n8n" = [ordered]@{
    latest = "0.1.0"
    description = "Workflow automation platform with AI integrations and persistent local state."
    source = "oci://ghcr.io/nandub/dockyard-packages/n8n"
    versions = @("0.1.0")
  }
  "searxng" = [ordered]@{
    latest = "0.1.0"
    description = "Privacy-respecting metasearch engine for web search and RAG support."
    source = "oci://ghcr.io/nandub/dockyard-packages/searxng"
    versions = @("0.1.0")
  }
}

function ConvertTo-CatalogYaml {
  param([hashtable]$Packages)

  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add("apiVersion: dockyard.dev/v1alpha1")
  $lines.Add("packages:")

  foreach ($name in ($Packages.Keys | Sort-Object)) {
    $pkg = $Packages[$name]
    $lines.Add("  ${name}:")
    $lines.Add("    latest: $($pkg.latest)")
    $lines.Add("    description: $($pkg.description)")
    $lines.Add("    source: $($pkg.source)")
    $lines.Add("    versions:")
    foreach ($version in $pkg.versions) {
      $lines.Add("      - $version")
    }
    $lines.Add("")
  }

  return ($lines -join [Environment]::NewLine) + [Environment]::NewLine
}

function Read-CatalogPackages {
  param([string]$Path)

  $lines = Get-Content $Path
  $packages = [ordered]@{}
  $currentName = $null
  $inVersions = $false

  foreach ($line in $lines) {
    if ($line -match '^\s{2}([A-Za-z0-9._-]+):\s*$') {
      $currentName = $Matches[1]
      $packages[$currentName] = [ordered]@{
        latest = ""
        description = ""
        source = ""
        versions = @()
      }
      $inVersions = $false
      continue
    }

    if ($null -eq $currentName) {
      continue
    }

    if ($line -match '^\s{4}latest:\s*(.+?)\s*$') {
      $packages[$currentName].latest = $Matches[1].Trim('"')
      $inVersions = $false
      continue
    }

    if ($line -match '^\s{4}description:\s*(.+?)\s*$') {
      $packages[$currentName].description = $Matches[1].Trim('"')
      $inVersions = $false
      continue
    }

    if ($line -match '^\s{4}source:\s*(.+?)\s*$') {
      $packages[$currentName].source = $Matches[1].Trim('"')
      $inVersions = $false
      continue
    }

    if ($line -match '^\s{4}versions:\s*$') {
      $inVersions = $true
      continue
    }

    if ($inVersions -and $line -match '^\s{6}-\s*(.+?)\s*$') {
      $packages[$currentName].versions += $Matches[1].Trim('"')
      continue
    }
  }

  return $packages
}

$packages = Read-CatalogPackages -Path $CatalogPath

foreach ($name in $entries.Keys) {
  $packages[$name] = $entries[$name]
}

$yaml = ConvertTo-CatalogYaml -Packages $packages
Set-Content -Path $CatalogPath -Value $yaml -Encoding UTF8

Write-Host "catalog.yaml updated with next-wave AI packages in alphabetical order."
