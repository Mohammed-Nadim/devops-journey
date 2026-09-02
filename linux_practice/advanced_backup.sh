#!/bin/bash
echo "=========================================="
echo "      LOG & FILE BACKUP MANAGER           "
echo "=========================================="

# ১. আর্গুমেন্ট আছে কিনা চেক করা ($1 = ফাইল বা ডিরেক্টরির নাম)
TARGET=$1

if [ -z "$TARGET" ]; then
    echo "Error: No target file/folder provided!"
    echo "Usage: ./advanced_backup.sh <file_or_folder_name>"
    exit 1 # ১ রিটার্ন করার মানে হলো স্ক্রিপ্ট ভুল বা ব্যর্থ হয়েছে
fi

# ২. টার্গেট ফাইল বা ফোল্ডার আছে কিনা দেখা
if [ -e "$TARGET" ]; then
    echo "Target '$TARGET' found. Simulating backup process..."
    sleep 1
    echo "Backup completed successfully for: $TARGET"
    exit 0 # ০ রিটার্ন করার মানে হলো কাজ সফল হয়েছে
else
    echo "Error: Target '$TARGET' does not exist!"
    exit 1
fi
