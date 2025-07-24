FROM python:3.11-slim

ENV PIP_NO_CACHE_DIR=1 PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
WORKDIR /app

# --- system deps ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl ca-certificates gnupg \
 && rm -rf /var/lib/apt/lists/*

# --- Node 20 for mcp-proxy ---
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y --no-install-recommends nodejs \
 && npm install -g mcp-proxy@latest \
 && rm -rf /var/lib/apt/lists/*

# --- clone server code (pin ref if you want) ---
ARG QDRANT_REPO_URL=https://github.com/amansingh0311/mcp-qdrant-openai.git
ARG QDRANT_REPO_REF=main
RUN git clone --depth=1 --branch ${QDRANT_REPO_REF} ${QDRANT_REPO_URL} /app

# --- python deps ---
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ENV PORT=8080 \
    QDRANT_URL=http://qdrant:6333 \
    QDRANT_API_KEY="" \
    OPENAI_API_KEY=""

EXPOSE 8080
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
