#!/bin/bash

# Remove existing image
docker rm -f mjy-dev-container

# Pull the Docker image
docker pull lygerin14/test:app-deploy

# Run the Docker container
docker run -d -p 8080:8080 --name mjy-dev-container lygerin14/test:app-deploy
