FROM node:20-alpine

WORKDIR /app
RUN apk add --no-cache git
ARG GRAPHDB_REPO_URL=https://github.com/keonchennl/mcp-graphdb.git
ARG GRAPHDB_REPO_REF=main
RUN git clone --depth=1 --branch ${GRAPHDB_REPO_REF} ${GRAPHDB_REPO_URL} /app

RUN npm install && npm run build
RUN npm install -g mcp-proxy@latest

ENV GRAPHDB_URL=http://graphdb:7200 \
    GRAPHDB_REPOSITORY=kg-llm \
    PORT=8080

EXPOSE 8080
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
