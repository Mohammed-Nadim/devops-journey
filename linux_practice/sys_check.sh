#!/bin/bash
echo "=========================================="
echo "         SYSTEM HEALTH REPORT             "
echo "=========================================="
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo "------------------------------------------"
echo "Memory Usage:"
free -h
echo "------------------------------------------"
echo "Disk Usage:"
df -h /
echo "=========================================="
