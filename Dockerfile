# change this to apache/superset:5.0.0 or whatever version you want to build from;
# otherwise the default is the latest commit on GitHub master branch
FROM apache/superset:5.0.0

USER root

# Install packages using uv into the virtual environment
# Superset started using uv after the 4.1 branch; if you are building from apache/superset:4.1.x or an older version,
# replace the first two lines with RUN pip install \
RUN pip install \
    # install psycopg2 for using PostgreSQL metadata store - could be a MySQL package if using that backend:
    psycopg2-binary \
    # add the driver(s) for your data warehouse(s), in this example we're showing for Microsoft SQL Server:
    pymssql \
    # package needed for using single-sign on authentication:
    Authlib \
    # openpyxl to be able to upload Excel files
    openpyxl \
    # Pillow for Alerts & Reports to generate PDFs of dashboards
    Pillow

# Switch back to the superset user
USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]