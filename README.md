# Golang Tekton Pipeline with signed Image and provenance

This example follows the blog post on Tekton Golang Pipline on [pxp928.com](https://pxp928.com/posts/2022/03/tekton-golang-pipeline-with-signed-provenance-slsa-level-2/).

## Prerequisites

- A running Kubernetes cluster (Docker Desktop Kubernetes, k3d, minikube)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- To install the Tekton CLI, there are multiple methods based on your OS. Navigate to the [Tekton CLI](https://github.com/tektoncd/cli#installing-tkn) repo to install
- Cosign Installed (this will be used for sigining the image)
    * If you have Go 1.16+, you can directly install by running:
    ```shell
    go install github.com/sigstore/cosign/cmd/cosign@latest
    ```
    * If you are using Homebrew (or Linuxbrew), you can install cosign by running:
    ```shell
    brew install cosign
    ```

## Steps

1. Deploy Tekton Pipelines (and optionally tekton dashboard is also installed)
    ```
    $ ./tekton-install.sh
    ```

2. Deploy Tekton Chains, modify configmap, and create signing secret via cosign (will have to enter password for private key or press enter to continue)
    ```
    $ ./chains-install.sh
    ```

3. Deploy Tekton Golang Tasks and initialize/execute pipeline
    ```
    $ ./go-pipeline.sh
    ```

4. Verify Results
    ```
    $ cosign verify --key k8s://tekton-chains/signing-secrets ttl.sh/example-123/go-build-test
    $ cosign verify-attestation --key k8s://tekton-chains/signing-secrets ttl.sh/example-123/go-build-test
    ```


