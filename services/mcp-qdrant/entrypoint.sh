#!/usr/bin/env sh
set -e
exec mcp-proxy --port "${PORT:-8080}" \
  python mcp_qdrant_server.py
