# nats

NATS server package with monitoring port.

This is a reusable Dockyard package intended for the `dockyard-packages` catalog.

## Usage

```powershell
dockyard package lint .\packages\nats --strict
dockyard package test .\packages\nats --strict
dockyard install nats .\packages\nats
```

For production, review `values.yaml`, provide secret values through environment variables or an external values file, and avoid committing real credentials.

## Security notes

- Images are pinned to non-`latest` tags.
- Services include health checks where the upstream image supports them.
- Host networking and privileged containers are disabled by policy.
- Named volumes are used instead of host path mounts.
- Secrets in `values.schema.json` are marked with `x-dockyard-sensitive`.


