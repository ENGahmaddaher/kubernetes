#!/bin/bash

set -e

NAMESPACE="${1:-default}"
BACKUP_DIR="/tmp/backup-$NAMESPACE-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "💾 Backing up namespace: $NAMESPACE"
RESOURCES=(
    "deployments"
    "services"
    "configmaps"
    "secrets"
    "ingress"
    "persistentvolumeclaims"
    "serviceaccounts"
    "roles"
    "rolebindings"
)
for RESOURCE in "${RESOURCES[@]}"; do
    echo "  → Exporting $RESOURCE..."
    kubectl get "$RESOURCE" -n "$NAMESPACE" -o yaml > "$BACKUP_DIR/$RESOURCE.yaml" 2>/dev/null || true
done


kubectl get pods -n "$NAMESPACE" -o yaml > "$BACKUP_DIR/pods.yaml" 2>/dev/null || true


tar -czf "$BACKUP_DIR.tar.gz" -C /tmp "$(basename "$BACKUP_DIR")"

echo "✅ Backup saved: $BACKUP_DIR.tar.gz"
echo "📋 Restore: ./restore-namespace.sh $NAMESPACE $BACKUP_DIR.tar.gz"
