#!/bin/bash

NAMESPACE="${1:-all}"


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "📊 Pod Status Report"
echo "==================="

if [ "$NAMESPACE" = "all" ]; then
    kubectl get pods -A --no-headers | while read -r NS POD READY STATUS RESTARTS AGE; do
        case "$STATUS" in
            "Running")
                echo -e "${GREEN}✓${NC} $NS/$POD → $STATUS ($READY ready)"
                ;;
            "CrashLoopBackOff"|"Error"|"Failed")
                echo -e "${RED}✗${NC} $NS/$POD → $STATUS (restarts: $RESTARTS)"
                ;;
            "Pending"|"ContainerCreating")
                echo -e "${YELLOW}⚠${NC} $NS/$POD → $STATUS"
                ;;
            *)
                echo "? $NS/$POD → $STATUS"
                ;;
        esac
    done
else
    kubectl get pods -n "$NAMESPACE" --no-headers | while read -r POD READY STATUS RESTARTS AGE; do
        case "$STATUS" in
            "Running")
                echo -e "${GREEN}✓${NC} $NAMESPACE/$POD → $STATUS"
                ;;
            "CrashLoopBackOff"|"Error"|"Failed")
                echo -e "${RED}✗${NC} $NAMESPACE/$POD → $STATUS (restarts: $RESTARTS)"
                ;;
            *)
                echo -e "${YELLOW}⚠${NC} $NAMESPACE/$POD → $STATUS"
                ;;
        esac
    done
fi
