#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  scripts/publish.sh PACKAGE [VERSION] [--registry REGISTRY] [--publish-catalog] [--catalog-ref REF]

Examples:
  scripts/publish.sh redis 0.2.0 --publish-catalog
  scripts/publish.sh opensearch
  scripts/publish.sh opensearch 0.1.0 --registry ghcr.io/my-org/dockyard-packages

Defaults:
  REGISTRY    ghcr.io/nandub/dockyard-packages
  CATALOG_REF ghcr.io/nandub/dockyard-packages/catalog:latest
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 2
fi

package="$1"
shift

version=""
registry="ghcr.io/nandub/dockyard-packages"
publish_catalog="false"
catalog_ref="ghcr.io/nandub/dockyard-packages/catalog:latest"

if [[ $# -gt 0 && "$1" != --* ]]; then
  version="$1"
  shift
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --registry)
      registry="${2:-}"
      shift 2
      ;;
    --publish-catalog)
      publish_catalog="true"
      shift
      ;;
    --catalog-ref)
      catalog_ref="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "unknown argument: $1" >&2
      usage
      exit 2
      ;;
  esac
done

package_dir="packages/$package"
manifest="$package_dir/Dockyard.yaml"

if [[ ! -d "$package_dir" ]]; then
  echo "package directory not found: $package_dir" >&2
  exit 1
fi

if [[ -z "$version" ]]; then
  if [[ ! -f "$manifest" ]]; then
    echo "Dockyard package manifest not found: $manifest" >&2
    exit 1
  fi
  version="$(awk -F: '/^[[:space:]]*version:[[:space:]]*/ {gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2); gsub(/^["'\''"]|["'\''"]$/, "", $2); print $2; exit}' "$manifest")"
  if [[ -z "$version" ]]; then
    echo "could not find version in $manifest; pass VERSION explicitly" >&2
    exit 1
  fi
fi

mkdir -p dist

archive="dist/$package-$version.dockyard.tgz"
ref="oci://$registry/$package:$version"

rm -f "$archive"

echo "==> lint $package@$version"
dockyard package lint "$package_dir" --strict

echo "==> test $package@$version"
dockyard package test "$package_dir" --strict

echo "==> package $package@$version"
dockyard package "$package_dir" -o "$archive"

echo "==> push $ref"
dockyard push "$archive" "$ref"

if [[ "$publish_catalog" == "true" ]]; then
  if [[ ! -f catalog.yaml ]]; then
    echo "catalog.yaml not found; cannot publish catalog index" >&2
    exit 1
  fi
  if ! command -v oras >/dev/null 2>&1; then
    echo "oras is required to publish the catalog index" >&2
    exit 1
  fi

  echo "==> publish catalog oci://$catalog_ref"
  oras push "$catalog_ref" "catalog.yaml:application/vnd.dockyard.catalog.v1+yaml" \
    --artifact-type "application/vnd.dockyard.catalog.v1+yaml"
fi

echo "published $package@$version to $ref"
