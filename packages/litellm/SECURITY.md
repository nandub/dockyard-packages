# LiteLLM package security notes

- The proxy binds to `127.0.0.1` by default.
- Change `security.masterKey` and `security.saltKey`.
- Do not commit provider API keys in values files or config files.
- Put the proxy behind TLS and authentication before remote access.
- Review LiteLLM logs and request/response retention settings before handling sensitive prompts.
