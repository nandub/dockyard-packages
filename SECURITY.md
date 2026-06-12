# Security Policy

## Supported packages

The `main` branch contains the current package catalog. Published package versions should be treated as immutable.

## Reporting a vulnerability

Open a private security advisory or contact the maintainer directly if a package default creates an avoidable security risk.

Do not include real credentials, private registry tokens, or production hostnames in public issues.

## Package security principles

- No hardcoded production secrets.
- No Docker socket mounts by default.
- No host networking by default.
- No privileged containers.
- Named volumes instead of host path mounts.
- `latest` image tags are disallowed.
- Secret-like values are marked in JSON Schema.
