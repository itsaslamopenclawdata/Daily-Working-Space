#!/bin/bash

# Daily Working Space - Auto Implementation Script
# Runs at 9AM daily or on system restart

REPO_DIR="/home/itsaslamautomations/.openclaw/workspace/Daily-Working-Space"
DATE_FILE=$(date +%Y-%m-%d)
LOG_FILE="$REPO_DIR/.cron_log.txt"

log() {
    echo "[$(date)] $1" | tee -a "$LOG_FILE"
}

log "=== Starting Daily Implementation Check ==="

# Navigate to repo
cd "$REPO_DIR" || exit 1

# Pull latest changes
git fetch origin main
LATEST_COMMIT=$(git rev-parse origin/main)
LAST_COMMIT=$(cat .last_commit 2>/dev/null)

if [ "$LATEST_COMMIT" = "$LAST_COMMIT" ]; then
    log "No new commits. Checking for action files..."
    
    # Check if today's action file exists
    if [ -f "${DATE_FILE}.md" ]; then
        log "Found today's action file: ${DATE_FILE}.md"
        cat "${DATE_FILE}.md"
    else
        log "No action file needed for today."
    fi
    exit 0
fi

log "New changes detected! Commit: $LATEST_COMMIT"

# Pull the latest
git pull origin main

# Check for markdown files changed/added
CHANGED_FILES=$(git diff --name-only "$LAST_COMMIT" "$LATEST_COMMIT" 2>/dev/null | grep '\.md$' || true)

if [ -z "$CHANGED_FILES" ]; then
    log "No markdown files changed. Creating general action file."
    cat > "${DATE_FILE}.md" << 'EOF'
# Daily Action Plan - $(date +%Y-%m-%d)

## Summary
No new changes detected in the repo. Review existing files for any pending actions.

## Existing Files to Review
EOF
    ls -1 *.md >> "${DATE_FILE}.md"
else
    log "Changed files: $CHANGED_FILES"
    
    # Create action plan based on changes
    cat > "${DATE_FILE}.md" << EOF
# Daily Action Plan - $(date +%Y-%m-%d)

## Changed Files
$(echo "$CHANGED_FILES" | sed 's/^/- /')

## Action Items

### Phase 1: Analysis
EOF
    
    for file in $CHANGED_FILES; do
        if [ -f "$file" ]; then
            echo "### Analyzing: $file" >> "${DATE_FILE}.md"
            echo "- Review content and extract action items" >> "${DATE_FILE}.md"
            echo "" >> "${DATE_FILE}.md"
        fi
    done
    
    cat >> "${DATE_FILE}.md" << 'EOF'

### Phase 2: Implementation
- [ ] Review all action items in changed files
- [ ] Execute implementation tasks (except config/plugin changes)
- [ ] Document any blockers or approval needed

### Phase 3: Follow-up
- [ ] Push any generated code to appropriate repos
- [ ] Update status in Master_Repo
- [ ] Create tomorrow's action plan

## Approval Required
- Config file changes: NEED APPROVAL
- New plugin/package installations: NEED APPROVAL
- External API changes: NEED APPROVAL
EOF
fi

log "Created action plan: ${DATE_FILE}.md"
cat "${DATE_FILE}.md"

# Commit and push the action plan
git add "${DATE_FILE}.md"
git commit -m "docs: Daily action plan $(date +%Y-%m-%d)" || log "No changes to commit"
git push origin main

# Update last commit
echo "$LATEST_COMMIT" > .last_commit

log "=== Daily Implementation Check Complete ==="
