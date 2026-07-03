# dockyard-packages

Reusable Dockyard package catalog for common Docker Compose applications.

This repository is intentionally separate from `nandub/dockyard`:

- `dockyard` is the package manager and CLI.
- `dockyard-packages` is a catalog of reusable packages.

The packages are conservative starters. They are designed for local-first development, repeatable validation, and safe customization through `values.yaml` or external values files.

## Package catalog

See [`docs/package-index.md`](docs/package-index.md) for the generated index.

Infrastructure:

- `postgres`
- `redis`
- `mariadb`
- `caddy`
- `traefik`
- `nginx`
- `adminer`
- `pgadmin`

Observability:

- `prometheus`
- `grafana`
- `loki`
- `alloy`
- `uptime-kuma`

Application platforms:

- `minio`
- `keycloak`
- `rabbitmq`
- `nats`
- `meilisearch`
- `typesense`

## Package layout

Each package has:

```text
Dockyard.yaml
compose.yaml
values.yaml
values.schema.json
README.md
SECURITY.md
LICENSE
```

## Validate all packages

```powershell
.\scripts\verify.ps1
```

On Linux/macOS:

```sh
./scripts/verify.sh
```

## Validate a single package

```powershell
dockyard package lint .\packages\postgres --strict
dockyard package test .\packages\postgres --strict
```

## Build a package archive

```powershell
dockyard package .\packages\postgres -o .\dist\postgres-0.1.0.dockyard.tgz
```

## Publish a package to GHCR

```powershell
dockyard push .\dist\postgres-0.1.0.dockyard.tgz `
  oci://ghcr.io/nandub/dockyard-packages/postgres:0.1.0
```

## Security posture

- No package uses `latest` image tags.
- Packages use named volumes instead of host path mounts.
- Host networking and privileged containers are disabled by policy.
- Docker socket mounts are avoided by default.
- Administrative UIs are examples only; expose them only on trusted networks.
- Development credentials are placeholders and must be overridden before real use.
- Secret-like values are marked with `x-dockyard-sensitive` in schemas.

## Production use

These packages are starters. Before production:

1. Pin image tags to versions your team has reviewed.
2. Use external values files or environment-backed values for secrets.
3. Configure TLS and authentication at the edge.
4. Review exposed ports.
5. Run `dockyard package lint --strict` and `dockyard package test --strict`.
6. Publish package archives to a registry you control.


MongoDB is included as an authentication-enabled, persistent, single-node replica set starter package.
