FROM apache/superset:5.0.0

USER root

COPY requirements-local.txt ./docker/requirements-local.txt
COPY --chown=superset superset_config.py /app/
ENV SUPERSET_CONFIG_PATH /app/superset_config.py

RUN pip install --no-cache-dir -r /app/requirements-local.txt

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]