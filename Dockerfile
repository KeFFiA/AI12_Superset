# change this to apache/superset:5.0.0 or whatever version you want to build from;
# otherwise the default is the latest commit on GitHub master branch
FROM apache/superset:5.0.0

USER root

RUN touch ./docker/requirements-local.txt
RUN echo "psycopg2-binary" >> ./docker/requirements-local.txt

# Switch back to the superset user
USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]