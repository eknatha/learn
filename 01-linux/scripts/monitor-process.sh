#!/usr/bin/env bash
# monitor-process.sh — Restart a process if it's not running
# Author: Eknatha Reddy | eknathalabs.com
# Usage: ./monitor-process.sh nginx "systemctl start nginx"

PROCESS_NAME="${1:-nginx}"
RESTART_CMD="${2:-systemctl start nginx}"
LOG="/var/log/process-monitor.log"

if ! pgrep -x "$PROCESS_NAME" > /dev/null; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $PROCESS_NAME not running. Restarting..." | tee -a "$LOG"
  eval "$RESTART_CMD"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Restart command executed." | tee -a "$LOG"
else
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $PROCESS_NAME is running. OK." >> "$LOG"
fi
