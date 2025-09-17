FROM apache/superset:5.0.0

USER root

COPY docker/requirements-local.txt /app/docker/requirements-local.txt

RUN apt-get install libpq-dev python-dev -y

RUN . /app/.venv/bin/activate && \
    uv pip install --no-cache-dir -r /app/docker/requirements-local.txt

COPY --chown=superset superset_config.py /app/
ENV SUPERSET_CONFIG_PATH /app/superset_config.py

USER superset

CMD [ "sh", "-c", "superset db upgrade && superset fab create-admin --username admin --firstname Admin --lastname Admin --email admin@admin.com --password admin || true && superset init && /app/docker/entrypoints/run-server.sh" ]

