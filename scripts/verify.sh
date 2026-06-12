#!/usr/bin/env sh
set -eu

DOCKYARD="${DOCKYARD:-dockyard}"

for pkg in packages/*; do
  [ -d "$pkg" ] || continue
  echo "==> $pkg"
  "$DOCKYARD" package lint "$pkg" --strict
  "$DOCKYARD" package test "$pkg" --strict
done
