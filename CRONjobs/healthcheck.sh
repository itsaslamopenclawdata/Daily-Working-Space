#!/bin/bash
# BeeManHoney Health Check Script
# Run via cron: */5 * * * * /path/to/healthcheck.sh

API_URL="http://localhost:8000/health"
FRONTEND_URL="http://localhost:3000"
ALERT_EMAIL="admin@beemanhoney.com"

check_service() {
    local name=$1
    local url=$2
    
    HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}" "$url")
    
    if [ "$HTTP_STATUS" != "200" ]; then
        echo ">>> ALERT: $name is DOWN (HTTP $HTTP_STATUS)"
        # Send alert email (configure SMTP first)
        # echo "Alert: $name down" | mail -s "BeeManHoney Alert" "$ALERT_EMAIL"
        return 1
    else
        echo ">>> OK: $name is healthy"
        return 0
    fi
}

echo "=== BeeManHoney Health Check - $(date) ==="

FAILED=0

check_service "API" "$API_URL" || FAILED=1
check_service "Frontend" "$FRONTEND_URL" || FAILED=1

if [ $FAILED -eq 1 ]; then
    echo ">>> Health check FAILED"
    exit 1
else
    echo ">>> All services healthy"
    exit 0
fi
