---
layout: default
title: Install in Fyde Access Proxy in Kubernetes
parent: Fyde Access Proxy
nav_order: 4
---
# Install in Kubernetes

- Pre-requisites:

  - Running [kubernetes cluster](https://kubernetes.io/){:target="_blank"} or local [minikube](https://kubernetes.io/docs/setup/minikube/){:target="_blank"} installation

  - Configured and installed [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/){:target="_blank"}

  - [Fyde Access Proxy enrollment link]({{ site.baseurl }}{% link fyde-enterprise-console/add-fyde-access-proxy.md %}#adding-a-proxy)

- The steps described assume familiarity with kubernetes

- The required images are available in Dockerhub registry under the organization [FydeInc](https://url.fyde.me/docker){:target="_blank"}

## Deploy manifests

1. Create the Envoy Proxy manifest file

    - Download the manifest file: [envoy-proxy.yaml]({{ site.baseurl }}{% link /fyde-access-proxy/kubernetes/envoy-proxy.yaml %}){:target="_blank"}

    - Ensure that configured public port for envoy matches the one configured in Fyde Enterprise Console for the corresponding Fyde Access Proxy

    - Update service anotations to match your environment

1. Create the Fyde Proxy Orchestrator manifest file

    - Download the manifest file: [fyde-proxy-orchestrator.yaml]({{ site.baseurl }}{% link /fyde-access-proxy/kubernetes/fyde-proxy-orchestrator.yaml %}){:target="_blank"}

    - Update **enrollment_token** value with Fyde Access Proxy enrollment link

1. Create namespace for the resources

    ```sh
    kubectl create namespace fyde-access-proxy
    ```

1. Apply the manifests

    ```sh
    kubectl apply \
      --namespace fyde-access-proxy \
      --filename=envoy-proxy.yaml \
      --filename=fyde-proxy-orchestrator.yaml
    ```

1. Get deployed resources

    ```sh
    kubectl get all \
      --namespace fyde-access-proxy
    ```

## Troubleshoot

- For troubleshooting steps please visit: [Troubleshooting]({{ site.baseurl }}{% link fyde-access-proxy/troubleshoot.md %})
