$ErrorActionPreference = "Stop"

$catalogPath = ".\catalog.yaml"

if (-not (Test-Path $catalogPath)) {
  throw "catalog.yaml not found"
}

$lines = Get-Content $catalogPath

$pkgIndex = -1
for ($i = 0; $i -lt $lines.Count; $i++) {
  if ($lines[$i] -eq "packages:") {
    $pkgIndex = $i
    break
  }
}

if ($pkgIndex -lt 0) {
  throw "catalog.yaml does not contain a top-level packages: key"
}

$header = @()
if ($pkgIndex -gt 0) {
  $header = $lines[0..($pkgIndex - 1)]
}

$tail = @()
if ($pkgIndex + 1 -lt $lines.Count) {
  $tail = $lines[($pkgIndex + 1)..($lines.Count - 1)]
}

$blocks = @()
$currentName = $null
$currentLines = @()

function Add-CurrentBlock {
  if ($script:currentName -and $script:currentLines.Count -gt 0) {
    $script:blocks += [pscustomobject]@{
      Name  = $script:currentName
      Lines = $script:currentLines
    }
  }
}

foreach ($line in $tail) {
  if ($line -match '^\s{2}- name:\s*([a-zA-Z0-9._-]+)\s*$') {
    Add-CurrentBlock
    $currentName = $Matches[1]
    $currentLines = @($line)
  } elseif ($currentName) {
    $currentLines += $line
  }
}
Add-CurrentBlock

if ($blocks.Count -eq 0) {
  throw "catalog.yaml packages: exists but does not contain list entries like '  - name: ...'"
}

$newEntries = @(
  [pscustomobject]@{
    Name = "anythingllm"
    Lines = @(
      "  - name: anythingllm",
      "    latest: 0.1.0",
      "    source: oci://ghcr.io/nandub/dockyard-packages/anythingllm",
      "    description: Self-hosted AI workspace for document chat and retrieval-augmented generation.",
      "    versions:",
      "      - 0.1.0"
    )
  },
  [pscustomobject]@{
    Name = "flowise"
    Lines = @(
      "  - name: flowise",
      "    latest: 0.1.0",
      "    source: oci://ghcr.io/nandub/dockyard-packages/flowise",
      "    description: Visual LLM workflow builder for chatbots, agents, and RAG pipelines.",
      "    versions:",
      "      - 0.1.0"
    )
  },
  [pscustomobject]@{
    Name = "n8n"
    Lines = @(
      "  - name: n8n",
      "    latest: 0.1.0",
      "    source: oci://ghcr.io/nandub/dockyard-packages/n8n",
      "    description: Workflow automation platform with AI integrations and persistent local state.",
      "    versions:",
      "      - 0.1.0"
    )
  },
  [pscustomobject]@{
    Name = "searxng"
    Lines = @(
      "  - name: searxng",
      "    latest: 0.1.0",
      "    source: oci://ghcr.io/nandub/dockyard-packages/searxng",
      "    description: Privacy-respecting metasearch engine for web search and RAG support.",
      "    versions:",
      "      - 0.1.0"
    )
  }
)

$replaceNames = $newEntries | ForEach-Object { $_.Name }

$merged = @()
$merged += $blocks | Where-Object { $_.Name -notin $replaceNames }
$merged += $newEntries
$merged = $merged | Sort-Object Name

$out = @()
$out += $header
$out += "packages:"

foreach ($block in $merged) {
  $out += $block.Lines
}

Set-Content -Path $catalogPath -Value $out -Encoding UTF8

Write-Host "catalog.yaml repaired with list-form package entries."
