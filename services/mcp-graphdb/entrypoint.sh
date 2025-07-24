#!/usr/bin/env sh
set -e
exec mcp-proxy --port "${PORT:-8080}" \
  node dist/index.js "${GRAPHDB_URL}" "${GRAPHDB_REPOSITORY}"
