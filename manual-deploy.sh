#!/bin/bash

set -e

NAMESPACE="astroops"

kubectl get namespace "$NAMESPACE" >/dev/null 2>&1 || \
kubectl create namespace "$NAMESPACE"

echo "Installing service accounts"

kubectl apply -f serviceaccounts.yaml -n "$NAMESPACE"

echo "Service accounts installed."

echo "============================================================="
echo "Deploying Helm chart for AstroOps in namespace $NAMESPACE"
echo "============================================================="

helm upgrade --install accounting ./accounting --namespace "$NAMESPACE"
helm upgrade --install ad ./ad --namespace "$NAMESPACE"
helm upgrade --install cart ./cart --namespace "$NAMESPACE"
helm upgrade --install checkout ./checkout --namespace "$NAMESPACE"
helm upgrade --install currency ./currency --namespace "$NAMESPACE"
helm upgrade --install email ./email --namespace "$NAMESPACE"
helm upgrade --install flagd ./flagd --namespace "$NAMESPACE"
helm upgrade --install frauddetection ./frauddetection --namespace "$NAMESPACE"
helm upgrade --install frontend ./frontend --namespace "$NAMESPACE"
helm upgrade --install frontendproxy ./frontendproxy --namespace "$NAMESPACE"
helm upgrade --install imageprovider ./imageprovider --namespace "$NAMESPACE"
helm upgrade --install kafka ./kafka --namespace "$NAMESPACE"
helm upgrade --install loadgenerator ./loadgenerator --namespace "$NAMESPACE"
helm upgrade --install payment ./payment --namespace "$NAMESPACE"
helm upgrade --install productcatalog ./productcatalog --namespace "$NAMESPACE"
helm upgrade --install quote ./quote --namespace "$NAMESPACE"
helm upgrade --install recommendation ./recommendation --namespace "$NAMESPACE"
helm upgrade --install shipping ./shipping --namespace "$NAMESPACE"
helm upgrade --install valkey ./valkey --namespace "$NAMESPACE"

echo "============================================================="
echo "Helm deployment completed"
echo "============================================================="

echo "Helm releases:"
helm list -n "$NAMESPACE"

echo "Pods:"
kubectl get pods -n "$NAMESPACE"

echo "Services:"
kubectl get svc -n "$NAMESPACE"

echo "Ingress:"
kubectl get ingress -n "$NAMESPACE"