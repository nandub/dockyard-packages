# Security - typesense

Report vulnerabilities through the main repository security policy.

Operational guidance:

- Rotate default development credentials before real use.
- Prefer environment references such as `${POSTGRES_PASSWORD}` or external values files.
- Keep image tags current and rebuild package archives after security updates.
- Run `dockyard package lint --strict` and `dockyard package test --strict` before publishing.
