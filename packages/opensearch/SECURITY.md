# Security Notes

- Replace `auth.initialAdminPassword` before deployment.
- Keep OpenSearch and Dashboards bound to `127.0.0.1` unless a private network, VPN, reverse proxy, or firewall explicitly protects them.
- OpenSearch 2.12 and later requires a custom initial admin password for the demo security configuration.
- The default package uses OpenSearch's demo security bootstrap, which is suitable for local/internal evaluation but not a complete production security configuration.
- Use custom TLS certificates, internal users, roles, mappings, and audit settings for production deployments.
- Configure `vm.max_map_count=262144` and Docker memory resources before starting.
- `no-new-privileges:true` is enabled for both services.
- Sensitive value override files should stay outside version control.
