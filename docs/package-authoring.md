# Package Authoring Guide

## Values

Keep `values.yaml` safe for local development, but never treat default values as production-ready secrets.

Good:

```yaml
password: "${POSTGRES_PASSWORD:-dockyard-dev-password}"
```

Bad:

```yaml
password: "real-production-password"
```

## Images

Use explicit tags. Do not use `latest`.

## Volumes

Use named volumes by default. Avoid host path mounts unless a package explicitly requires host integration.

## Administrative UIs

Packages such as Adminer, pgAdmin, Grafana, MinIO console, and RabbitMQ management should only be exposed on trusted networks.

## Validation

```sh
dockyard package lint ./packages/postgres --strict
dockyard package test ./packages/postgres --strict
```

## Publishing

Build:

```sh
dockyard package ./packages/postgres -o ./dist/postgres-0.1.0.dockyard.tgz
```

Push:

```sh
dockyard push ./dist/postgres-0.1.0.dockyard.tgz \
  oci://ghcr.io/nandub/dockyard-packages/postgres:0.1.0
```
