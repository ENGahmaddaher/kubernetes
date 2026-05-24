#!/bin/bash

set -e

NAMESPACE="${1:-all}"
LABEL_KEY="${2:-monitoring}"
LABEL_VALUE="${3:-enabled}"

echo "📌 Adding label $LABEL_KEY=$LABEL_VALUE to pods..."

if [ "$NAMESPACE" = "all" ]; then
    kubectl get pods -A --no-headers | while read -r NS POD _; do
        echo "  → $NS/$POD"
        kubectl label pod "$POD" "$LABEL_KEY=$LABEL_VALUE" -n "$NS" --overwrite 2>/dev/null || true
    done
else
    kubectl get pods -n "$NAMESPACE" --no-headers | while read -r POD _; do
        echo "  → $NAMESPACE/$POD"
        kubectl label pod "$POD" "$LABEL_KEY=$LABEL_VALUE" -n "$NAMESPACE" --overwrite
    done
fi

echo "✅ Done!"
