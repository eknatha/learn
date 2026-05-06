#!/usr/bin/env bash
# check-disk.sh — Alert when disk usage exceeds threshold
# Author: Eknatha Reddy | eknathalabs.com

THRESHOLD=80
HOSTNAME=$(hostname)

df -h | awk 'NR>1' | while read line; do
  USAGE=$(echo "$line" | awk '{print $5}' | tr -d '%')
  MOUNT=$(echo "$line" | awk '{print $6}')
  if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "[ALERT] $(date '+%Y-%m-%d %H:%M:%S') | $HOSTNAME | $MOUNT is at ${USAGE}%"
    # Add your notification here: mail, Slack webhook, PagerDuty, etc.
  fi
done
