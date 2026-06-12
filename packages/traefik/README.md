# traefik

Traefik reverse proxy starter package using static entrypoints only.

This is a reusable Dockyard package intended for the `dockyard-packages` catalog.

## Usage

```powershell
dockyard package lint .\packages\traefik --strict
dockyard package test .\packages\traefik --strict
dockyard install traefik .\packages\traefik
```

For production, review `values.yaml`, provide secret values through environment variables or an external values file, and avoid committing real credentials.

## Security notes

- Images are pinned to non-`latest` tags.
- Services include health checks where the upstream image supports them.
- Host networking and privileged containers are disabled by policy.
- Named volumes are used instead of host path mounts.
- Secrets in `values.schema.json` are marked with `x-dockyard-sensitive`.

This starter intentionally does not mount the Docker socket. Add providers in a package overlay only when you accept the associated risk.
