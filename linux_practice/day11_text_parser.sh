#!/bin/bash
LOG_FILE="linux_practice/server.log"

echo "=================================================="
echo "          LOG ANALYSIS & TEXT PROCESSING          "
echo "=================================================="

if [ ! -f "$LOG_FILE" ]; then
    echo "[ERROR] Log file $LOG_FILE not found!"
    exit 1
fi

echo "[INFO] Filtering ERROR logs using grep:"
grep "ERROR" "$LOG_FILE"
echo "--------------------------------------------------"

echo "[INFO] Extracting specific log columns using awk:"
awk '/ERROR/ {print "Time: " $2 " | Event: " $3 " | IP/Details: " $6}' "$LOG_FILE"
echo "--------------------------------------------------"

echo "[INFO] Masking IP addresses using sed:"
sed 's/192\.168\.1/XXX.XXX.X/g' "$LOG_FILE"
echo "=================================================="
exit 0
