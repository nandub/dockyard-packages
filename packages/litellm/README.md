# LiteLLM Dockyard package

Runs LiteLLM Proxy as an OpenAI-compatible gateway for local and hosted LLM providers.

## Defaults

- Proxy: `127.0.0.1:4000`
- Static `config.yaml` points at Ollama on `host.docker.internal:11434`.
- No hosted provider API keys are included.

Install Ollama first for the default local provider path:

```powershell
dockyard install ollama
dockyard install litellm
```

Before production use, replace `security.masterKey`, `security.saltKey`, and `config.yaml` with your intended providers and model routes.
