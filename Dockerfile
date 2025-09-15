# Dockerfile
FROM apache/superset:latest

USER root

RUN apt-get update && apt-get install -y build-essential libpq-dev && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir psycopg2-binary flask-cors redis

USER superset
