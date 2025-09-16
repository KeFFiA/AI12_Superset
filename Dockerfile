# Используйте нужную версию Superset
FROM apache/superset:5.0.0

USER root


RUN . /app/.venv/bin/activate && \
    uv pip install \
    psycopg2-binary \
    pymssql \
    Authlib \
    openpyxl \
    Pillow

COPY --chown=superset superset_config.py /app/
ENV SUPERSET_CONFIG_PATH /app/superset_config.py

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]