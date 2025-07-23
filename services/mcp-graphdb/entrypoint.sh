#!/usr/bin/env sh
set -e

# Dist script is created by npm run build
# Pass GRAPHDB_URL and GRAPHDB_REPOSITORY as positional args (expected by the server)
exec npx -y mcp-proxy --port "${PORT:-8080}" \
  node dist/index.js "${GRAPHDB_URL}" "${GRAPHDB_REPOSITORY}"
