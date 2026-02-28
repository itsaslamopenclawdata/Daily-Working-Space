#!/bin/bash
# BeeManHoney Database Backup Script
# Run via cron: 0 2 * * * /path/to/backup.sh

BACKUP_DIR="/backups/beemanhoney"
DATE=$(date +%Y-%m-%d_%H%M%S)
DB_NAME="beemanhoney"
DB_USER="admin"

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

echo ">>> Starting database backup..."

# PostgreSQL backup
docker exec beemanhoney-db pg_dump -U "$DB_USER" "$DB_NAME" | gzip > "$BACKUP_DIR/db_${DATE}.sql.gz"

# Keep only last 7 backups
find "$BACKUP_DIR" -name "db_*.sql.gz" -mtime +7 -delete

echo ">>> Backup complete: db_${DATE}.sql.gz"
echo ">>> Backup size: $(du -h "$BACKUP_DIR/db_${DATE}.sql.gz" | cut -f1)"
