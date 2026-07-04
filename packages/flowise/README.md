# Flowise Dockyard package

Flowise is a visual builder for LLM applications, agents, and retrieval workflows.

## Defaults

- Binds the UI to `127.0.0.1:3000`.
- Persists Flowise data in a named Docker volume mounted at `/root/.flowise`.
- Enables basic authentication with schema-marked sensitive password value.
- Does not include model provider API keys.

## Install

```powershell
dockyard install flowise
```

For shared environments, override `auth.password` before first install.
