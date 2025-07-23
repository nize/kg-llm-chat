# ---------- build & runtime in one (simple) stage ----------
FROM node:20-alpine

WORKDIR /app

# Install git to clone the repo
RUN apk add --no-cache git

# Pin to a specific commit or tag to avoid surprises
ARG GRAPHDB_REPO_URL=https://github.com/keonchennl/mcp-graphdb.git
ARG GRAPHDB_REPO_REF=main
RUN git clone --depth=1 --branch ${GRAPHDB_REPO_REF} ${GRAPHDB_REPO_URL} /app

# Install deps & build (repo uses tsup -> creates dist/)
RUN npm install && npm run build

# mcp-proxy to expose stdio over HTTP
RUN npm install -g mcp-proxy@latest

# Default envs (override in docker-compose)
ENV GRAPHDB_URL=http://graphdb:7200 \
    GRAPHDB_REPOSITORY=kg-llm \
    PORT=8080

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
