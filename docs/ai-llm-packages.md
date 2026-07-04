# AI and LLM package notes

This catalog update adds the first wave of AI/LLM-oriented packages:

- `ollama@0.1.0` for local model serving.
- `open-webui@0.1.0` for a browser-based chat interface.
- `qdrant@0.1.0` for vector search and RAG storage.
- `litellm@0.1.0` for an OpenAI-compatible gateway/proxy.

## Recommended install order

```powershell
dockyard install ollama
dockyard install open-webui
dockyard install qdrant
dockyard install litellm
```

## Security defaults

All packages bind public-facing ports to `127.0.0.1` by default. Change tokens and keys before shared or production use. Do not commit model-provider API keys.

## Publishing

Use the generic publisher:

```powershell
.\scripts\publish.ps1 -Package ollama -PublishCatalog
.\scripts\publish.ps1 -Package open-webui -PublishCatalog
.\scripts\publish.ps1 -Package qdrant -PublishCatalog
.\scripts\publish.ps1 -Package litellm -PublishCatalog
```
