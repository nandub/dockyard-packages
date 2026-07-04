# AI/LLM next-wave packages

This patch adds four Dockyard packages:

- `flowise@0.1.0`
- `anythingllm@0.1.0`
- `n8n@0.1.0`
- `searxng@0.1.0`

All packages use flat Dockyard manifests:

```yaml
apiVersion: dockyard.dev/v1alpha1
name: package-name
version: 0.1.0
```

They intentionally do not use Kubernetes-style `kind` or `metadata` fields.

## Publishing

```powershell
.\scripts\publish.ps1 -Package flowise -PublishCatalog
.\scripts\publish.ps1 -Package anythingllm -PublishCatalog
.\scripts\publish.ps1 -Package n8n -PublishCatalog
.\scripts\publish.ps1 -Package searxng -PublishCatalog
```
