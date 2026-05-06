#!/usr/bin/env bash
# log-parser.sh — Extract errors and warnings from logs
# Author: Eknatha Reddy | eknathalabs.com
# Usage: ./log-parser.sh /var/log/syslog

LOG_FILE="${1:-/var/log/syslog}"
OUTPUT_DIR="/tmp/log-report"
mkdir -p "$OUTPUT_DIR"

REPORT="$OUTPUT_DIR/report-$(date +%Y%m%d-%H%M%S).txt"

echo "=== Log Analysis Report ===" > "$REPORT"
echo "File: $LOG_FILE" >> "$REPORT"
echo "Time: $(date)" >> "$REPORT"
echo "" >> "$REPORT"

echo "--- ERROR count: $(grep -ci 'error' "$LOG_FILE") ---" >> "$REPORT"
grep -i 'error' "$LOG_FILE" | tail -20 >> "$REPORT"

echo "" >> "$REPORT"
echo "--- WARNING count: $(grep -ci 'warn' "$LOG_FILE") ---" >> "$REPORT"
grep -i 'warn' "$LOG_FILE" | tail -20 >> "$REPORT"

echo "" >> "$REPORT"
echo "--- CRITICAL count: $(grep -ci 'crit' "$LOG_FILE") ---" >> "$REPORT"
grep -i 'crit' "$LOG_FILE" | tail -10 >> "$REPORT"

echo "Report saved to: $REPORT"
cat "$REPORT"
