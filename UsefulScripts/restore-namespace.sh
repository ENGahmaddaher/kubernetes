#!/bin/bash

set -e

NAMESPACE="${1:-default}"
BACKUP_FILE="${2}"

if [ -z "$BACKUP_FILE" ]; then
    echo "❌ Usage: $0 <namespace> <backup-file.tar.gz>"
    exit 1
fi

TEMP_DIR="/tmp/restore-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$TEMP_DIR"

echo "🔄 Restoring namespace: $NAMESPACE from $BACKUP_FILE"


tar -xzf "$BACKUP_FILE" -C "$TEMP_DIR"
BACKUP_DIR=$(find "$TEMP_DIR" -type d -name "backup-*" | head -1)


for FILE in "$BACKUP_DIR"/*.yaml; do
    if [ -f "$FILE" ]; then
        echo "  → Applying $(basename "$FILE")"
        kubectl apply -f "$FILE" --namespace="$NAMESPACE" 2>/dev/null || true
    fi
done

echo "✅ Restore completed!"
rm -rf "$TEMP_DIR"
