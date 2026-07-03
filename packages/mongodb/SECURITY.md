# MongoDB package security

## Defaults

- MongoDB authentication is enabled.
- The published port is bound to `127.0.0.1` by default.
- Data is stored in a named Docker volume.
- The package uses a pinned major/minor image tag rather than `latest`.

## Operator responsibilities

- Override `auth.rootPassword` with a long random secret before installation.
- Keep values files outside version control.
- Restrict network exposure if changing `service.bindHost`.
- Back up MongoDB data and test restores.
- Use a dedicated multi-node design with keyfile authentication for high-availability production deployments.
