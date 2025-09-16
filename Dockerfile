FROM apache/superset:5.0.0
USER root

RUN apt-get update && apt-get install -y build-essential

RUN . /app/.venv/bin/activate && \
    pip install \
    psycopg2-binary \
    pymssql \
    Authlib \
    openpyxl \
    Pillow

USER superset
CMD ["/app/docker/entrypoints/run-server.sh"]