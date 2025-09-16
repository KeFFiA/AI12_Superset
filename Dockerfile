FROM apache/superset:5.0.0
USER root

RUN apt-get update && apt-get install -y build-essential

COPY superset_config.py /app/pythonpath/superset_config.py
COPY docker/requirements-local.txt /app/docker/requirements-local.txt

USER superset
CMD ["/app/docker/entrypoints/run-server.sh"]