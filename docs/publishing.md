# Publishing Packages

This repository publishes Dockyard packages as OCI artifacts.

## Manual package publish

```powershell
New-Item -ItemType Directory -Force .\dist | Out-Null

dockyard package .\packages\postgres `
  -o .\dist\postgres-0.1.0.dockyard.tgz

dockyard push .\dist\postgres-0.1.0.dockyard.tgz `
  oci://ghcr.io/nandub/dockyard-packages/postgres:0.1.0
```

## Package naming

Use:

```text
ghcr.io/nandub/dockyard-packages/<package>:<package-version>
```

Example:

```text
ghcr.io/nandub/dockyard-packages/postgres:0.1.0
```

## CI workflow

The publish workflow is manual and requires:

- `package`: directory name under `packages/`
- `version`: version tag, for example `0.1.0`

It builds the archive and pushes it with Dockyard.
