#!/bin/bash

set -e

NAMESPACE="${1:-dev}"
DAYS="${2:-7}"
OLD_DATE=$(date -d "$DAYS days ago" -Iseconds)

echo "🧹 Cleaning up resources older than $DAYS days in namespace: $NAMESPACE"


echo "  → Deleting completed/failed pods..."
kubectl delete pods -n "$NAMESPACE" --field-selector status.phase=Succeeded --ignore-not-found
kubectl delete pods -n "$NAMESPACE" --field-selector status.phase=Failed --ignore-not-found


echo "  → Deleting completed jobs..."
kubectl delete jobs -n "$NAMESPACE" --field-selector status.successful=1 --ignore-not-found

echo "  → Deleting old pods (older than $DAYS days)..."
kubectl get pods -n "$NAMESPACE" -o json | \
    jq -r --arg OLD_DATE "$OLD_DATE" \
    '.items[] | select(.metadata.creationTimestamp < $OLD_DATE) | .metadata.name' | \
    while read -r POD; do
        echo "    - Deleting old pod: $POD"
        kubectl delete pod "$POD" -n "$NAMESPACE" --ignore-not-found
    done

echo "✅ Cleanup completed!"
