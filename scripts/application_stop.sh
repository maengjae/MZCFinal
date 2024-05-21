#!/bin/bash
# Stop the Docker container if it's running
docker stop mjy-dev-container || true
docker rm mjy-dev-container || true
