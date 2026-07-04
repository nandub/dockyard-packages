# Generic package publishing

Use the reusable publishing scripts instead of package-specific publish scripts.

PowerShell:

```powershell
.\scripts\publish.ps1 -Package opensearch -PublishCatalog
.\scripts\publish.ps1 -Package redis -Version 0.2.0 -PublishCatalog
```

Bash:

```bash
scripts/publish.sh opensearch --publish-catalog
scripts/publish.sh redis 0.2.0 --publish-catalog
```

Defaults:

- Registry: `ghcr.io/nandub/dockyard-packages`
- Catalog ref: `ghcr.io/nandub/dockyard-packages/catalog:latest`

The scripts lint, test, package, push the package OCI artifact, and optionally publish `catalog.yaml` as the catalog OCI artifact.
