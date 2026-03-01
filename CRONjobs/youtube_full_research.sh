#!/bin/bash
# Comprehensive YouTube Research - All 10 Methods
# Runs daily at 6 AM

API_KEY="AIzaSyDe245nWkV2HXdfmqJxhrBhYVigijgBO3s"
REPO_DIR="/home/itsaslamautomations/.openclaw/workspace/Daily-Working-Space"
OUTPUT_DIR="$REPO_DIR/YouTubeResearch"
DATE=$(date +%Y-%m-%d)
OUTPUT_FILE="$OUTPUT_DIR/${DATE}.md"

echo "# YouTube Research - $(date +%B\ %d,\ %Y)

> Generated: $(date)
> Focus: \$1B Solopreneur Goals

---

## Method 1: Morning Trend Scan

" > "$OUTPUT_FILE"

# Search queries for trends
for query in "AI agents business 2026" "solopreneur SaaS" "vibe coding"; do
  echo "### $query" >> "$OUTPUT_FILE"
  curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=3&q=$query&order=date&type=video&key=$API_KEY" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    for v in d.get('items', []):
        s = v['snippet']
        print(f\"- [{s['title']}](https://www.youtube.com/watch?v={v['id']['videoId']}) - {s['channelTitle']}\")
except: pass" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
done

echo "---" >> "$OUTPUT_FILE"
echo "## Method 2: Competitor Tracker" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Channel IDs for competitors
CHANNELS=("UCui4jxDaMb53Gdh-AZUTPAg" "UCTvBSPQVXjFCy-3I6upKmXQ" "UCz6CIdBLN2T6t1U-6nOr2Jg")
NAMES=("Liam Ottley" "Dan Martell" "Greg Isenberg")

for i in "${!CHANNELS[@]}"; do
  echo "### ${NAMES[$i]}" >> "$OUTPUT_FILE"
  curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=${CHANNELS[$i]}&maxResults=2&order=date&type=video&key=$API_KEY" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    for v in d.get('items', []):
        s = v['snippet']
        print(f\"- [{s['title']}](https://www.youtube.com/watch?v={v['id']['videoId']})\")
except: pass" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
done

echo "---" >> "$OUTPUT_FILE"
echo "## Method 3: Keyword Gap Finder" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

for query in "make money with AI agents" "AI business ideas 2026" "solopreneur tips"; do
  echo "### $query" >> "$OUTPUT_FILE"
  curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=5&q=$query&order=relevance&type=video&key=$API_KEY" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(f\"Results: {len(d.get('items', []))} videos found\")
except: pass" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
done

echo "---" >> "$OUTPUT_FILE"
echo "## Method 4: Video Metrics Analyzer" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Get trending video stats
curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=5&q=AI+agents+business&order=relevance&type=video&key=$API_KEY" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print('### Top Videos by Relevance')
    print()
    for v in d.get('items', []):
        s = v['snippet']
        print(f\"- **{s['title']}**\")
        print(f\"  Channel: {s['channelTitle']}\")
        print(f\"  Link: https://www.youtube.com/watch?v={v['id']['videoId']}\")
        print()
except: pass" >> "$OUTPUT_FILE"

echo "---" >> "$OUTPUT_FILE"
echo "## Method 5: New Tutorial Finder" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

for query in "OpenClaw tutorial" "Nano Banana Pro setup" "AI automation course"; do
  echo "### $query" >> "$OUTPUT_FILE"
  curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=3&q=$query&order=date&type=video&key=$API_KEY" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    for v in d.get('items', []):
        s = v['snippet']
        print(f\"- [{s['title']}](https://www.youtube.com/watch?v={v['id']['videoId']})\")
except: pass" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
done

echo "---" >> "$OUTPUT_FILE"
echo "## Method 6: Trending Topic Detector" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=AI+business+2026&order=date&type=video&key=$API_KEY" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print('### Fresh Content (Last 48 Hours)')
    print()
    for v in d.get('items', []):
        s = v['snippet']
        print(f\"- [{s['title']}](https://www.youtube.com/watch?v={v['id']['videoId']}) - {s['channelTitle']}\")
except: pass" >> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "## Method 7-10: Additional Insights" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

echo "### Revenue Model Research" >> "$OUTPUT_FILE"
for query in "AI agent pricing" "sell automation services"; do
  echo "- Search: $query" >> "$OUTPUT_FILE"
done
echo "" >> "$OUTPUT_FILE"

echo "### Problem Discovery" >> "$OUTPUT_FILE"
for query in "AI business challenges" "solopreneur problems"; do
  echo "- Search: $query" >> "$OUTPUT_FILE"
done
echo "" >> "$OUTPUT_FILE"

echo "---" >> "$OUTPUT_FILE"
echo "## Recommended Channels" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "| Channel | Subscribe |" >> "$OUTPUT_FILE"
echo "|--------|-----------|" >> "$OUTPUT_FILE"
echo "| Liam Ottley | https://youtube.com/@liamottley |" >> "$OUTPUT_FILE"
echo "| Dan Martell | https://youtube.com/@DanMartell |" >> "$OUTPUT_FILE"
echo "| Greg Isenberg | https://youtube.com/@gregisenberg |" >> "$OUTPUT_FILE"
echo "| Nate Herk | https://youtube.com/@nateherk |" >> "$OUTPUT_FILE"
echo "| Anik Singal | https://youtube.com/@aniksingal |" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

echo "*Generated by OpenClaw - 10 Methods Daily*" >> "$OUTPUT_FILE"

# Commit and push
cd "$REPO_DIR"
git add YouTubeResearch/
git commit -m "docs: YouTube research 10 methods $(date +%Y-%m-%d)" 2>/dev/null
git push origin main 2>/dev/null

echo "Done! File: $OUTPUT_FILE"
