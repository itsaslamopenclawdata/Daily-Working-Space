#!/bin/bash
# BeeManHoney Rollback Script
# Source: Docs/16_Deployment_Playbook.md

echo ">>> Rolling back to previous stable tag..."
# Assumes you tag images like :v1, :v2.
# Export PREV_TAG before running.

export IMAGE_TAG="${PREV_TAG:-"v1.0.0"}"
docker-compose -f docker-compose.prod.yml up -d
echo ">>> Rolled back to $IMAGE_TAG"
