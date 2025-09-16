FROM apache/superset:5.0.0

USER root

# копируем конфиг и requirements
COPY superset_config.py /app/
COPY docker/requirements-local.txt /app/requirements-local.txt
ENV SUPERSET_CONFIG_PATH /app/superset_config.py

# убедимся, что работаем в правильном виртуальном окружении
ENV PATH="/app/.venv/bin:$PATH"

# ставим зависимости в venv Superset
RUN pip install --no-cache-dir -r /app/requirements-local.txt

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
