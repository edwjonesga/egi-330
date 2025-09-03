#!/bin/bash

# Start MySQL service in the background
echo "Starting MySQL service..."
service mysql start

# Execute the command passed to this script (e.g., /bin/bash)
exec "$@"
