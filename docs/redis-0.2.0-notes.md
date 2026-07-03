# Redis 0.2.0 notes

`redis@0.2.0` replaces the lightweight Redis defaults with production-oriented settings:

- named `/data` volume
- AOF and RDB persistence
- required password
- authenticated health check
- loopback-only port binding
- Redis and Docker memory controls
- disabled `FLUSHALL`, `FLUSHDB`, and `CONFIG`
- `no-new-privileges:true`

Publish the package, then publish `catalog.yaml` so `redis` resolves to `0.2.0`.
