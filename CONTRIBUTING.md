# Contributing

## Package requirements

Every package must include:

- `Dockyard.yaml`
- `compose.yaml`
- `values.yaml`
- `values.schema.json`
- `README.md`
- `SECURITY.md`
- `LICENSE`

Run before opening a pull request:

```sh
./scripts/verify.sh
```

or on Windows:

```powershell
.\scripts\verify.ps1
```

## Security expectations

- Do not commit real secrets.
- Do not use `latest` image tags.
- Avoid host path mounts and Docker socket mounts.
- Add health checks whenever the upstream image supports them.
- Mark secret-like schema fields with `x-dockyard-sensitive`.
