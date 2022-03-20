#!/bin/bash

# Setup Tekton.
echo "Installing Tekton Pipeline..."
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl rollout status -n tekton-pipelines deployment/tekton-pipelines-controller
kubectl rollout status -n tekton-pipelines deployment/tekton-pipelines-webhook

echo "Installing Tekton Dashboard..."
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
kubectl rollout status -n tekton-pipelines deployment/tekton-dashboard
