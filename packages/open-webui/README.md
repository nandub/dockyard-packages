# Open WebUI Dockyard package

Runs Open WebUI, a self-hosted interface for Ollama and OpenAI-compatible APIs.

## Defaults

- Web UI: `127.0.0.1:3000`
- App data volume: `open-webui-data:/app/backend/data`
- Ollama base URL from container: `http://host.docker.internal:11434`

Install Ollama first when using the default configuration:

```powershell
dockyard install ollama
dockyard install open-webui
```

Open <http://127.0.0.1:3000> after startup.
