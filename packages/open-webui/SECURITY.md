# Open WebUI package security notes

- The UI binds to `127.0.0.1` by default.
- Change `security.webuiSecretKey` for shared or production environments.
- Put the UI behind TLS and authentication controls before remote exposure.
- Do not place provider API keys in committed values files.
