# AI next-wave catalog patch

This patch adds the next-wave AI packages to `catalog.yaml` alphabetically:

- anythingllm
- flowise
- n8n
- searxng

It also replaces `scripts/check-dockyard-manifests.ps1` with a clean version that has no stray leading backslash.

## Apply

```powershell
cd C:\Users\ferna\development\code\go\dockyard-packages
Expand-Archive .\dockyard-packages-ai-next-wave-catalog-patch.zip -DestinationPath . -Force
.\scripts\apply-ai-next-wave-catalog.ps1
.\scripts\check-dockyard-manifests.ps1
```

## Verify

```powershell
Select-String -Path .\catalog.yaml -Pattern "anythingllm|flowise|n8n|searxng"

.\scripts\publish-catalog.ps1
Remove-Item C:\Users\ferna\.dockyard\cache\catalogs -Recurse -Force -ErrorAction SilentlyContinue

dockyard catalog info anythingllm
dockyard catalog info flowise
dockyard catalog info n8n
dockyard catalog info searxng
```
