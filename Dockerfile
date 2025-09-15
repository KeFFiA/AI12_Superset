# Dockerfile
FROM apache/superset:latest

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     build-essential \
     libpq-dev \
     python3-dev \
     gcc \
  && /app/python3 -m ensurepip \
  && /app/.venv/bin/pip install --upgrade pip setuptools wheel \
  && /app/.venv/bin/pip install --no-cache-dir psycopg2-binary flask-cors redis \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER superset
