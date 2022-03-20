#!/bin/bash

# Setup Tekton Chains.
echo "Installing Tekton Chains..."
kubectl apply --filename https://storage.googleapis.com/tekton-releases/chains/latest/release.yaml
kubectl rollout status -n tekton-chains deployment/tekton-chains-controller

echo "Patching Tekton Chains configmap..."
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"artifacts.taskrun.format": "in-toto"}}'
kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"artifacts.taskrun.storage": "oci"}}'

echo "Creating signing secret via cosign"
cosign generate-key-pair k8s://tekton-chains/signing-secrets
