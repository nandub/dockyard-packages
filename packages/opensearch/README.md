# OpenSearch Dockyard Package

This package runs a single-node OpenSearch deployment with OpenSearch Dashboards for local development, evaluation, and small internal environments.

## What it includes

- OpenSearch single-node mode.
- OpenSearch Dashboards connected to the OpenSearch service.
- Persistent named volume mounted at `/usr/share/opensearch/data`.
- Loopback-only host port bindings by default.
- Demo security configuration with a required initial admin password.
- JVM heap configuration.
- `memlock` and `nofile` ulimits.
- Docker memory limits and reservations.
- Health checks for OpenSearch and Dashboards.
- `security_opt: no-new-privileges:true`.

## Install

```powershell
dockyard install opensearch
```

After publishing to the catalog, this resolves to:

```text
oci://ghcr.io/nandub/dockyard-packages/opensearch:0.1.0
```

## Access

OpenSearch API:

```powershell
curl.exe -k -u admin:<password> https://localhost:9200
```

OpenSearch Dashboards:

```text
http://localhost:5601
```

The username is `admin`. The password comes from `auth.initialAdminPassword`.

## Required host settings

OpenSearch requires host tuning before it will run reliably.

Linux:

```bash
sudo swapoff -a
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
cat /proc/sys/vm/max_map_count
```

Windows with Docker Desktop/WSL:

```powershell
wsl -d docker-desktop
sysctl -w vm.max_map_count=262144
```

Docker Desktop should have at least 4 GB of memory available.

## Override values

Create a values file outside the repository, for example `opensearch-values.yaml`:

```yaml
auth:
  initialAdminPassword: "replace-with-a-strong-password"

service:
  bindHost: 127.0.0.1
  httpPort: 9200
  performanceAnalyzerPort: 9600

dashboards:
  service:
    bindHost: 127.0.0.1
    port: 5601

java:
  heap: 1g

resources:
  limits:
    memory: 3G
  reservations:
    memory: 2G
```

Install with:

```powershell
dockyard install opensearch -f .\opensearch-values.yaml
```

## Production notes

This package intentionally uses a single-node deployment and the built-in demo security bootstrap. For production, use a multi-node cluster, custom TLS certificates, custom internal users/roles, verified backups, and carefully planned resource sizing.

Do not expose ports `9200`, `9600`, or `5601` directly to the public internet.
