# Qdrant package security notes

- Ports bind to `127.0.0.1` by default.
- Change `security.apiKey` and `security.readOnlyApiKey`.
- Use TLS at a reverse proxy or service mesh boundary before remote exposure.
- Back up both storage and snapshot volumes.
