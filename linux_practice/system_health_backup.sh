#!/bin/bash

# ==============================================================================
# Mini Project: System Health Audit, Log Parser & Automated Backup Suite
# Author: Mohammed Nadim
# ==============================================================================

LOG_SOURCE="linux_practice/server.log"
BACKUP_DIR="linux_practice/backups"
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
REPORT_FILE="linux_practice/health_report_${TIMESTAMP}.txt"

OBSERVIUM_IP="10.0.8.30"
OBSERVIUM_PORT="8080"

echo "==================================================" > "$REPORT_FILE"
echo "        SYSTEM HEALTH & AUDIT REPORT              " >> "$REPORT_FILE"
echo "        Generated: $(date)                        " >> "$REPORT_FILE"
echo "==================================================" >> "$REPORT_FILE"

# [0] MONITORING SERVER CHECK (Observium)
echo -e "\n[0] MONITORING SERVER HEALTH (Observium):" >> "$REPORT_FILE"
nc -z -w 2 $OBSERVIUM_IP $OBSERVIUM_PORT 2>/dev/null
if [ $? -eq 0 ]; then
    echo "Observium Server ($OBSERVIUM_IP:$OBSERVIUM_PORT) is UP & Reachable." >> "$REPORT_FILE"
else
    echo "WARNING: Observium Server ($OBSERVIUM_IP:$OBSERVIUM_PORT) is UNREACHABLE!" >> "$REPORT_FILE"
    echo "$(date +'%Y-%m-%d %H:%M:%S') ERROR Observium server unreachable ip=$OBSERVIUM_IP" >> "$LOG_SOURCE"
fi

# [1] SYSTEM HEALTH AUDIT (Disk Usage via awk)
echo -e "\n[1] DISK USAGE AUDIT:" >> "$REPORT_FILE"
df -h / | awk 'NR==2 {print "Total Disk Space: " $2 " | Used: " $3 " (" $5 ")"}' >> "$REPORT_FILE"

# [2] LOG ERROR ANALYSIS (grep & awk)
echo -e "\n[2] ERROR LOG ANALYSIS (grep & awk):" >> "$REPORT_FILE"
if [ -f "$LOG_SOURCE" ]; then
    ERROR_COUNT=$(grep -c "ERROR" "$LOG_SOURCE")
    echo "Total Critical Errors Found: $ERROR_COUNT" >> "$REPORT_FILE"
    echo "Extracted Error Details:" >> "$REPORT_FILE"
    awk '/ERROR/ {print " -> Time: " $2 " | Message: " $4 " " $5 " " $6}' "$LOG_SOURCE" >> "$REPORT_FILE"
else
    echo "Log source file not found!" >> "$REPORT_FILE"
fi

# [3] AUTOMATED MASKED BACKUP (sed & tar)
echo -e "\n[3] AUTOMATED BACKUP STATUS:" >> "$REPORT_FILE"
mkdir -p "$BACKUP_DIR"
MASKED_LOG="${BACKUP_DIR}/masked_server_${TIMESTAMP}.log"

if [ -f "$LOG_SOURCE" ]; then
    sed 's/192\.168\.1/XXX.XXX.X/g' "$LOG_SOURCE" > "$MASKED_LOG"
    
    ARCHIVE_NAME="${BACKUP_DIR}/system_backup_${TIMESTAMP}.tar.gz"
    tar -czf "$ARCHIVE_NAME" "$MASKED_LOG" 2>/dev/null
    
    echo "Masked Log Created: $MASKED_LOG" >> "$REPORT_FILE"
    echo "Archive Backup Created: $ARCHIVE_NAME" >> "$REPORT_FILE"
    rm -f "$MASKED_LOG"
fi

echo -e "\n==================================================" >> "$REPORT_FILE"
echo "Report saved to $REPORT_FILE"

# Display result
cat "$REPORT_FILE"
