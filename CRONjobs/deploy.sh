#!/bin/bash
# BeeManHoney Deployment Script
# Source: Docs/16_Deployment_Playbook.md

set -e

APP_NAME="beemanhoney"
TAG="${1:-latest}"

echo ">>> 1. Pulling latest images..."
docker-compose -f docker-compose.prod.yml pull

echo ">>> 2. Applying Database Migrations..."
docker-compose -f docker-compose.prod.yml run --rm api alembic upgrade head

echo ">>> 3. Rolling Update..."
docker-compose -f docker-compose.prod.yml up -d --remove-orphans

echo ">>> 4. Health Check..."
sleep 10
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" http://localhost:8000/health)

if [ "$HTTP_STATUS" == "200" ]; then
    echo ">>> Deployment SUCCESS! System is live."
else
    echo ">>> ERROR: Health check failed with status $HTTP_STATUS"
    exit 1
fi
