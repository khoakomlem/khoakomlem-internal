#!/bin/bash

# Load .env file if it exists
if [ -f .env ]; then
  export $(cat .env | grep -v '^#' | xargs)
fi

# setup.sh
VOLUMES_PATH=${VOLUMES_PATH:-./volumes}

mkdir -p "$VOLUMES_PATH/jenkins"
mkdir -p "$VOLUMES_PATH/sonarqube/data"
mkdir -p "$VOLUMES_PATH/sonarqube/logs"
mkdir -p "$VOLUMES_PATH/sonarqube/extensions"
mkdir -p "$VOLUMES_PATH/postgres"

echo "Volume directories created at $VOLUMES_PATH"

docker compose -f docker-compose.yml -p dev-space up -d
