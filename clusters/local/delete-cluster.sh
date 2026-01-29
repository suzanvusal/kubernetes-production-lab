#!/usr/bin/env bash
set -e

CLUSTER_NAME="k8s-prod-lab"

echo "🧹 Deleting Kubernetes cluster: $CLUSTER_NAME"

kind delete cluster --name $CLUSTER_NAME

echo "✅ Cluster deleted"
