# Qdrant Dockyard package

Runs Qdrant for vector search and retrieval-augmented generation workloads.

## Defaults

- HTTP API: `127.0.0.1:6333`
- gRPC API: `127.0.0.1:6334`
- Storage volume: `qdrant-storage:/qdrant/storage`
- Snapshots volume: `qdrant-snapshots:/qdrant/snapshots`
- API keys enabled through environment configuration.

## Install

```powershell
dockyard install qdrant
```

Change both API keys before shared or production use.
