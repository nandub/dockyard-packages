# Dockyard catalog repair patch

This patch repairs `catalog.yaml` after the previous patch overwrote it with only the next-wave AI packages.

It restores the catalog as a `packages:` YAML list and includes the next-wave entries alphabetically:
- anythingllm
- flowise
- n8n
- searxng

Run from the dockyard-packages repository root:

```powershell
Expand-Archive .\dockyard-packages-catalog-repair.zip -DestinationPath . -Force
.\scripts\repair-ai-next-wave-catalog.ps1
dockyard catalog list --json
.\scripts\publish-catalog.ps1
Remove-Item C:\Users\ferna\.dockyard\cache\catalogs -Recurse -Force -ErrorAction SilentlyContinue
dockyard catalog info anythingllm
dockyard catalog info flowise
dockyard catalog info n8n
dockyard catalog info searxng
```
