# AnythingLLM Dockyard package

AnythingLLM is a self-hosted RAG and AI agent workspace.

## Defaults

- Binds the web UI to `127.0.0.1:3001`.
- Persists application storage in a named Docker volume.
- Does not include model provider API keys.
- Uses a schema-marked sensitive JWT secret.

## Install

```powershell
dockyard install anythingllm
```

Change `security.jwtSecret` before use in shared environments.
