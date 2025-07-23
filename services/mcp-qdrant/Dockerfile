# ---------- base image ----------
FROM python:3.11-slim AS base

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# System deps: git + curl (for healthchecks if needed)
RUN apt-get update && apt-get install -y --no-install-recommends git curl \
    && rm -rf /var/lib/apt/lists/*

# Clone repo (pin a ref for reproducibility)
ARG QDRANT_REPO_URL=https://github.com/amansingh0311/mcp-qdrant-openai.git
ARG QDRANT_REPO_REF=main
RUN git clone --depth=1 --branch ${QDRANT_REPO_REF} ${QDRANT_REPO_URL} /app

# Python deps
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Node just to run mcp-proxy (smallest: node:alpine is heavy to bring in here,
# but simplest is installing nodejs+npm quickly)
RUN apt-get update && apt-get install -y --no-install-recommends nodejs npm \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g mcp-proxy@latest

# Defaults (override in compose)
ENV OPENAI_API_KEY="" \
    QDRANT_URL="http://qdrant:6333" \
    QDRANT_API_KEY="" \
    PORT=8080

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
