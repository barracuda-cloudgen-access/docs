# Install Fyde Proxy in Kubernetes

- Pre-requisites:

  - Running [kubernetes cluster](https://kubernetes.io/) or local [minikube](https://kubernetes.io/docs/setup/minikube/) instalation

  - Configured and installed [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

  - [Proxy Enrollment Link](../console/configurations/add_proxy.md#adding-a-proxy)

- The steps described assume familiarity with kubernetes

- The required images are available in Dockerhub registry under the organization [FydeInc](https://hub.docker.com/u/fydeinc)

## Deploy manifests

1. Create the envoy proxy manifest file

    - Download the manifest file:

        - [kubernetes/envoy-proxy.yaml](kubernetes/envoy-proxy.yaml)

    - Make sure the Access Proxy (envoy) port, as configured in the management console, is allowed in the firewall

    - If required, update anotations to match your environment

1. Create the proxy client manifest file

    - Download the manifest file:

        - [kubernetes/proxy-client.yaml](kubernetes/proxy-client.yaml)

    - Update `enrollment_token` value with `Proxy Enrollment Link`

1. Create namespace for the resources

    ```sh
    kubectl create namespace fyde-proxy
    ```

1. Apply the manifests

    ```sh
    kubectl apply \
      --namespace fyde-proxy \
      --filename=envoy-proxy.yaml \
      --filename=proxy-client.yaml
    ```

1. Get deployed resources

    ```sh
    kubectl get all \
      --namespace fyde-proxy
    ```
