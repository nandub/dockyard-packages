# MongoDB

MongoDB document database packaged for Dockyard with authentication, a named data volume, and a single-node replica set.

This package intentionally defaults to a **single-node replica set** rather than a standalone MongoDB container. That gives development and small Compose stacks access to MongoDB features such as multi-document transactions and change streams without requiring a three-node cluster.

## Install

Create a values file outside the repository, for example `../deploy-values/mongodb.yaml`:

```yaml
auth:
  rootUsername: root
  rootPassword: replace-with-a-long-random-password

database:
  name: app

replicaSet:
  name: rs0
  host: mongodb:27017
```

Install from a local checkout:

```powershell
dockyard install mongodb ./packages/mongodb -f ..\deploy-values\mongodb.yaml
```

After the package is published to the official catalog, users can install it with:

```powershell
dockyard install mongodb
```

## Connection strings

For applications running on the same Compose network, keep the default replica set host:

```text
mongodb://root:<password>@mongodb:27017/app?replicaSet=rs0&authSource=admin
```

For host-machine clients, set `replicaSet.host` to `localhost:27017` before first initialization and connect through the published loopback port:

```yaml
replicaSet:
  host: localhost:27017
```

```text
mongodb://root:<password>@localhost:27017/app?replicaSet=rs0&authSource=admin
```

MongoDB stores replica set member hostnames in its data volume. Changing `replicaSet.host` after first initialization usually requires reconfiguring the replica set manually or recreating the volume.

## Values

| Name | Default | Description |
| --- | --- | --- |
| `image.repository` | `mongo` | MongoDB image repository. |
| `image.tag` | `7.0` | MongoDB image tag. Avoid `latest` for repeatable deployments. |
| `service.bindHost` | `127.0.0.1` | Host interface for the published MongoDB port. |
| `service.port` | `27017` | Host port mapped to container port `27017`. |
| `auth.rootUsername` | `root` | Initial root user for an empty data volume. |
| `auth.rootPassword` | `change-me-in-values` | Initial root password. Override this before use. |
| `database.name` | `app` | Initial database name. |
| `replicaSet.name` | `rs0` | Replica set name. |
| `replicaSet.host` | `mongodb:27017` | Host recorded in `rs.initiate()`. Choose based on client location. |

## Security notes

- Authentication is enabled through `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`.
- The default port bind is loopback-only: `127.0.0.1:27017`.
- Data is stored in the named volume `mongodb-data`.
- The root password only initializes users on an empty data volume. Changing it later does not update an existing MongoDB user.
- Do not commit real values files, `.env` files, database dumps, or generated keyfiles.
- This package is not a high-availability MongoDB deployment.

## Replica set and keyfile scope

This package provides a single-node replica set for local-first and small Compose use cases. A production multi-node replica set requires a shared MongoDB keyfile, strict file permissions, multiple persistent volumes, explicit hostnames, and a separate initialization job. That shape is intentionally not the default package because it requires operator-provided secrets and environment-specific topology.

## Backup and restore

Replication is not a backup strategy. Use `mongodump`/`mongorestore` or your preferred backup tooling, store backups outside the container volume, and test restores regularly.

## Validation

```powershell
dockyard package lint ./packages/mongodb --strict
dockyard package test ./packages/mongodb --strict
dockyard package ./packages/mongodb -o ./dist/mongodb-0.1.0.dockyard.tgz
```
