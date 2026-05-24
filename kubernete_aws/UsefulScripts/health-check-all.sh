#!/bin/bash

set -e

echo "🏥 Cluster Health Check"
echo "======================"
echo ""

echo "📊 Nodes:"
kubectl get nodes
echo ""

echo "📊 Unhealthy Pods (Not Running/Completed):"
kubectl get pods -A --no-headers | grep -v -E "Running|Completed" || echo "  ✓ All pods healthy"
echo ""


echo "📊 Pods with high restarts (>5):"
kubectl get pods -A --no-headers | awk '$5 > 5 {print "  ⚠️ " $1 "/" $2 " - restarts: " $5}' || echo "  ✓ No high restart pods"
echo ""


echo "📊 Resource Usage (if metrics-server available):"
kubectl top pods -A --no-headers 2>/dev/null | head -10 || echo "  ⚠️ metrics-server not available"
echo ""


echo "📊 Recent Events (last 5):"
kubectl get events -A --sort-by='.lastTimestamp' | tail -5
echo ""

echo "✅ Health check completed!"
