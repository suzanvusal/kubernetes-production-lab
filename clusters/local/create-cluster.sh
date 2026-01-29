#!/usr/bin/env bash
set -e

CLUSTER_NAME="k8s-prod-lab"

echo "🚀 Creating Kubernetes cluster: $CLUSTER_NAME"

kind create cluster --name $CLUSTER_NAME --config kind-config.yaml

echo "✅ Cluster created successfully"

kubectl cluster-info
kubectl get nodes -o wide
