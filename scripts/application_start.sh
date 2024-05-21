#!/bin/bash

# Pull the Docker image
docker pull lygerin14/test:app-deploy

# Run the Docker container
docker run -d -e db_endpoint=DB_ENDPOINT -p 8080:8080 --name mjy-dev-container lygerin14/test:app-deploy
