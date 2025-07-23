#!/usr/bin/env sh
set -e

# Run the Python MCP server through mcp-proxy
exec npx -y mcp-proxy --port "${PORT:-8080}" \
  python mcp_qdrant_server.py
