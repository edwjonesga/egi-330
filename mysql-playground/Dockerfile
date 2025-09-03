FROM mysql:8.3

# Set env vars for default setup
ENV MYSQL_ROOT_PASSWORD=rootpass
ENV MYSQL_DATABASE=exampledb

# Copy init script if needed
COPY init.sql /docker-entrypoint-initdb.d/

# Default command drops into bash
CMD ["bash"]
