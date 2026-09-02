#!/bin/bash
echo "=========================================="
echo "      FILE PERMISSION INSPECTOR           "
echo "=========================================="

# যে ফাইলের পারমিশন আমরা পরীক্ষা করব সেটি ভ্যারিয়েবলে সেভ করা
TARGET_FILE="linux_practice/sys_check.sh"

# ফাইলটি আছে কিনা তা চেক করা (if condition)
if [ -f "$TARGET_FILE" ]; then
    echo "Checking permissions for $TARGET_FILE..."
    # ফাইলের বর্তমান Numeric Permission (যেমন: 755 বা 644) বের করা
    PERM=$(stat -c "%a" "$TARGET_FILE" 2>/dev/null || stat -f "%Lp" "$TARGET_FILE" 2>/dev/null || echo "N/A")
    echo "Current permission mode: $PERM"
    
    # ফাইলটিতে স্বয়ংক্রিয়ভাবে 755 (Read, Write, Execute for Owner; Read, Execute for Group/Others) পারমিশন সেট করা
    chmod 755 "$TARGET_FILE"
    echo "Updated permission mode to: 755 (rwxr-xr-x)"
else
    echo "Target file $TARGET_FILE does not exist!"
fi
echo "=========================================="
