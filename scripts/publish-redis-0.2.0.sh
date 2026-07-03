#!/usr/bin/env bash
set -euo pipefail

mkdir -p dist
rm -f dist/redis-0.2.0.dockyard.tgz

dockyard package ./packages/redis -o ./dist/redis-0.2.0.dockyard.tgz
dockyard push ./dist/redis-0.2.0.dockyard.tgz "oci://ghcr.io/nandub/dockyard-packages/redis:0.2.0"

./scripts/publish-catalog.sh
