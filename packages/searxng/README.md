# SearXNG Dockyard package

SearXNG is a privacy-preserving metasearch service that can support RAG and web-search workflows.

## Defaults

- Binds to `127.0.0.1:8080`.
- Persists `/etc/searxng` configuration in a named Docker volume.
- Drops Linux capabilities except the small set commonly used by the container image.
- Does not expose a public search endpoint by default.

## Install

```powershell
dockyard install searxng
```

If exposing SearXNG beyond localhost, configure a reverse proxy, rate limiting, and bot protection.
