# CRONjobs - Automation Scripts

This folder contains all automation scripts for the itsaslamopenclawdata organization projects.

## Scripts

### 1. daily_implementation.sh
**Purpose:** Daily automation for Daily-Working-Space repo  
**Schedule:** 9 AM daily + on system restart  
**Description:** Pulls latest changes, detects new commits, creates action files

```bash
# Cron entry:
0 9 * * * /path/to/daily_implementation.sh
```

### 2. deploy.sh
**Purpose:** Deploy BeeManHoney to production  
**Usage:** `./deploy.sh [tag]`

```bash
# Example:
./deploy.sh latest
./deploy.sh v1.0.0
```

### 3. rollback.sh
**Purpose:** Rollback to previous stable version  
**Usage:** Set PREV_TAG before running

```bash
# Example:
PREV_TAG=v1.0.0 ./rollback.sh
```

### 4. backup.sh
**Purpose:** Daily database backup  
**Schedule:** Recommended: 2 AM daily

```bash
# Cron entry:
0 2 * * * /path/to/backup.sh
```

### 5. healthcheck.sh
**Purpose:** Monitor service health every 5 minutes  
**Schedule:** Recommended: Every 5 minutes

```bash
# Cron entry:
*/5 * * * * /path/to/healthcheck.sh
```

## Cron Setup

### Install Cron Jobs
```bash
# Make scripts executable
chmod +x *.sh

# Edit crontab
crontab -e

# Add entries:
0 9 * * * /path/to/daily_implementation.sh >> /var/log/daily_impl.log 2>&1
0 2 * * * /path/to/backup.sh >> /var/log/backup.log 2>&1
*/5 * * * * /path/to/healthcheck.sh >> /var/log/healthcheck.log 2>&1
```

## Service Monitoring

| Service | URL | Expected |
|---------|-----|----------|
| API | http://localhost:8000/health | 200 OK |
| Frontend | http://localhost:3000 | 200 OK |
| Database | localhost:5432 | pg_isready |
| Redis | localhost:6379 | PING |

## Notes

- All scripts are designed for Docker-based deployments
- Configure SMTP settings for email alerts
- Ensure proper permissions before running
- Check logs for debugging

---
Last Updated: February 28, 2026
