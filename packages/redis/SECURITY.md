# Security Notes

- Replace the default `auth.password` before deployment.
- Keep Redis bound to `127.0.0.1` unless an explicit private network design requires otherwise.
- Do not expose port 6379 directly to the internet.
- `FLUSHALL`, `FLUSHDB`, and `CONFIG` are disabled by default using `rename-command`.
- `no-new-privileges:true` is enabled.
- Resource limits are configured to reduce the chance of host-wide memory exhaustion.
- Store sensitive value override files outside version control.
