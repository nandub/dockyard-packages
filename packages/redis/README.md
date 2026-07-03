# Redis

Redis-compatible in-memory data store with production-oriented Docker Compose defaults.

## What this package provides

- Named volume mounted at `/data`.
- AOF persistence enabled with `appendfsync everysec`.
- RDB snapshots enabled for fast snapshot-style backups.
- Password authentication enabled by default through `requirepass`.
- Loopback-only published port by default.
- Redis health check using authenticated `redis-cli ping`.
- Redis `maxmemory` and eviction policy configuration.
- Docker memory limit/reservation values.
- `no-new-privileges:true` container hardening.
- Destructive/admin commands `FLUSHALL`, `FLUSHDB`, and `CONFIG` disabled by default.

## Install

```powershell
dockyard install redis
```

Or pin this version explicitly:

```powershell
dockyard install redis catalog://redis:0.2.0
```

## Values

Override the default password before deployment:

```yaml
auth:
  password: "replace-with-a-long-random-password"
```

The default port binding is loopback-only:

```yaml
service:
  bindHost: 127.0.0.1
  port: 6379
```

Do not expose Redis directly to the internet. Use a private Docker network, VPN, SSH tunnel, or trusted internal network path.

## Persistence

Redis data is stored in the named Docker volume `redis-data` at `/data`. This package enables both AOF and RDB persistence:

- AOF reduces expected data loss to roughly the configured fsync interval.
- RDB snapshots provide compact point-in-time files that are useful for backup/restore workflows.

## Backup example

```powershell
docker exec redis redis-cli -a "<password>" BGSAVE
docker run --rm -v redis_redis-data:/data:ro -v ${PWD}:/backup alpine tar czf /backup/redis-data-backup.tar.gz -C /data .
```

Test restores regularly. Persistence is not a substitute for independent backups.
