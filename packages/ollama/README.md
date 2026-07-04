# Ollama Dockyard package

Runs Ollama as a local LLM runtime with model data persisted in a named Docker volume.

## Defaults

- Image: `ollama/ollama:0.31.1`
- API: `127.0.0.1:11434`
- Data volume: `ollama-models:/root/.ollama`
- No model is downloaded automatically during install.

## Usage

```powershell
dockyard install ollama
```

Pull a model after install:

```powershell
docker exec -it ollama-ollama-1 ollama pull llama3.2
```

## GPU

GPU support is intentionally not enabled by default. Add a local Compose overlay or custom package variant for NVIDIA/ROCm hosts after validating the host runtime.
