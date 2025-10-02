FROM apache/superset:5.0.0

USER root

COPY docker/requirements-local.txt /app/docker/requirements-local.txt

RUN apt-get update && apt-get install -y libpq-dev python3-dev && rm -rf /var/lib/apt/lists/*

RUN . /app/.venv/bin/activate && \
    uv pip install --no-cache-dir -r /app/docker/requirements-local.txt && uv pip install --upgrade pyarrow

COPY --chown=superset superset_config.py /app/
ENV SUPERSET_CONFIG_PATH /app/superset_config.py

USER superset

CMD [ "sh", "-c", "superset db upgrade && superset init && /app/docker/entrypoints/run-server.sh" ]

