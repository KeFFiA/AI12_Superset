# Базовый образ с Python 3.11
FROM python:3.11-slim

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libpq-dev \
       gcc \
       git \
       curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash superset
USER superset
WORKDIR /home/superset

RUN pip install --no-cache-dir --upgrade pip setuptools wheel \
    && pip install --no-cache-dir apache-superset psycopg2-binary flask-cors redis

RUN mkdir -p .volumes/superset_home

COPY superset_config.py /home/superset/pythonpath/superset_config.py

EXPOSE 8088

# EntryPoint
CMD ["superset", "run", "-p", "8088", "--with-threads", "--reload", "--debugger"]