#!/usr/bin/env sh
set -eu

DOCKYARD="${DOCKYARD:-dockyard}"

if [ ! -f catalog.yaml ]; then
  echo "catalog.yaml is required" >&2
  exit 1
fi

for pkg in packages/*; do
  [ -d "$pkg" ] || continue
  echo "==> $pkg"
  "$DOCKYARD" package lint "$pkg" --strict
  "$DOCKYARD" package test "$pkg" --strict
done
