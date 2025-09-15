# Dockerfile
FROM apache/superset:latest

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     build-essential \
     libpq-dev \
     python3-dev \
     gcc \
  && pip install --no-cache-dir psycopg2-binary \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir flask-cors redis

USER superset
