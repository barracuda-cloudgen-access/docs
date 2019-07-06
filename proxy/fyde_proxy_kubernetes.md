# Install Fyde Access Proxy in Kubernetes

- Pre-requisites:

  - Running [kubernetes cluster](https://kubernetes.io/) or local [minikube](https://kubernetes.io/docs/setup/minikube/) installation

  - Configured and installed [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

  - [Fyde Access Proxy enrollment link](../console/configurations/add_proxy.md#adding-a-proxy)

- The steps described assume familiarity with kubernetes

- The required images are available in Dockerhub registry under the organization [FydeInc](https://url.fyde.me/docker)

## Deploy manifests

1. Create the Envoy Proxy manifest file

    - Download the manifest file:

        - [kubernetes/envoy-proxy.yaml](kubernetes/envoy-proxy.yaml)

    - Make sure the Fyde Access Proxy port, as configured in Fyde Enterprise Console, is allowed in the firewall

    - If required, update service anotations to match your environment

1. Create the Fyde Proxy Orchestrator manifest file

    - Download the manifest file:

        - [kubernetes/fyde-proxy-orchestrator.yaml](kubernetes/fyde-proxy-orchestrator.yaml)

    - Update `enrollment_token` value with Fyde Access Proxy enrollment link

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

- For troubleshooting steps please visit: [Troubleshooting](./fyde_proxy_troubleshoot.md)
