# uptime-kuma

Uptime Kuma monitoring package.

This is a reusable Dockyard package intended for the `dockyard-packages` catalog.

## Usage

```powershell
dockyard package lint .\packages\uptime-kuma --strict
dockyard package test .\packages\uptime-kuma --strict
dockyard install uptime-kuma .\packages\uptime-kuma
```

For production, review `values.yaml`, provide secret values through environment variables or an external values file, and avoid committing real credentials.

## Security notes

- Images are pinned to non-`latest` tags.
- Services include health checks where the upstream image supports them.
- Host networking and privileged containers are disabled by policy.
- Named volumes are used instead of host path mounts.
- Secrets in `values.schema.json` are marked with `x-dockyard-sensitive`.


