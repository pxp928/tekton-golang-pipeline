#!/bin/bash

set -e -o pipefail

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Install Golang tasks.
echo "Installing git-clone task..."
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.5/git-clone.yaml
echo "Installing golang-build task..."
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/golang-build/0.3/golang-build.yaml
echo "Installing golang-test task..."
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/golang-test/0.2/golang-test.yaml
echo "Installing trivy-scanner task..."
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/trivy-scanner/0.1/trivy-scanner.yaml
echo "Installing kaniko task..."
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kaniko/0.6/kaniko.yaml

# Running Golang Tekton Pipeline
echo "Creating shared workspace pvc..."
kubectl apply -f "$DIR"/config/pvc.yaml

echo "Creating Golang pipeline..."
kubectl apply -f "$DIR"/config/go-pipeline.yaml
echo "Executing Golang Pipeline..."
kubectl create -f "$DIR"/config/go-pipelinerun.yaml

echo "View Golang Pipelinerun..."
tkn pr logs --last -f
