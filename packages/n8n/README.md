# n8n Dockyard package

n8n is a workflow automation platform with AI-capable nodes and integrations.

## Defaults

- Binds the UI to `127.0.0.1:5678`.
- Persists workflow and credential data in a named Docker volume.
- Sets a schema-marked sensitive encryption key.
- Disables diagnostics/personalization telemetry by default.

## Install

```powershell
dockyard install n8n
```

Change `app.encryptionKey` before first use in shared or long-lived deployments.
