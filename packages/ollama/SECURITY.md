# Ollama package security notes

- The API binds to `127.0.0.1` by default.
- Do not expose Ollama directly to untrusted networks.
- Model files persist in a named volume.
- No model is auto-pulled by default to avoid surprise storage and bandwidth usage.
- Review model licenses and data-handling behavior before production use.
