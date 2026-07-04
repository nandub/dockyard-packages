# OpenSearch 0.1.0

Adds a catalog package for OpenSearch with OpenSearch Dashboards.

## Design

- Single-node OpenSearch default for local/internal use.
- OpenSearch Dashboards included by default.
- Loopback-only host ports.
- Named data volume.
- Initial admin password is required and schema-marked as sensitive.
- JVM heap, ulimits, Docker memory controls, and health checks are configurable.

## Publish

```powershell
dockyard package .\packages\opensearch -o .\dist\opensearch-0.1.0.dockyard.tgz
dockyard push .\dist\opensearch-0.1.0.dockyard.tgz "oci://ghcr.io/nandub/dockyard-packages/opensearch:0.1.0"
.\scripts\publish-catalog.ps1
```
