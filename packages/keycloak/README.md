# keycloak

Keycloak identity provider starter package using dev mode.

This is a reusable Dockyard package intended for the `dockyard-packages` catalog.

## Usage

```powershell
dockyard package lint .\packages\keycloak --strict
dockyard package test .\packages\keycloak --strict
dockyard install keycloak .\packages\keycloak
```

For production, review `values.yaml`, provide secret values through environment variables or an external values file, and avoid committing real credentials.

## Security notes

- Images are pinned to non-`latest` tags.
- Services include health checks where the upstream image supports them.
- Host networking and privileged containers are disabled by policy.
- Named volumes are used instead of host path mounts.
- Secrets in `values.schema.json` are marked with `x-dockyard-sensitive`.

This package uses Keycloak `start-dev` for local-first development. Use a production overlay with an external database and TLS before real deployment.
