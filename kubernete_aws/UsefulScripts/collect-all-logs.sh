#!/bin/bash

set -e

NAMESPACE="${1:-all}"
SINCE_HOURS="${2:-1}"
OUTPUT_DIR="/tmp/logs-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$OUTPUT_DIR"

echo "📋 Collecting logs from last $SINCE_HOURS hour(s)..."

if [ "$NAMESPACE" = "all" ]; then
    kubectl get pods -A --no-headers | while read -r NS POD _; do
        LOG_FILE="$OUTPUT_DIR/${NS}_${POD}.log"
        echo "  → $NS/$POD -> $LOG_FILE"
        kubectl logs "$POD" -n "$NS" --since="${SINCE_HOURS}h" > "$LOG_FILE" 2>&1 || true
    done
else
    kubectl get pods -n "$NAMESPACE" --no-headers | while read -r POD _; do
        LOG_FILE="$OUTPUT_DIR/${NAMESPACE}_${POD}.log"
        echo "  → $NAMESPACE/$POD -> $LOG_FILE"
        kubectl logs "$POD" -n "$NAMESPACE" --since="${SINCE_HOURS}h" > "$LOG_FILE" 2>&1
    done
fi

tar -czf "$OUTPUT_DIR.tar.gz" -C /tmp "$(basename "$OUTPUT_DIR")"
echo "✅ Logs saved: $OUTPUT_DIR.tar.gz"
