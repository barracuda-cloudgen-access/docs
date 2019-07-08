# Fyde Access Proxy

- Fyde Access Proxy is the software combo that contains Envoy Proxy and Fyde Proxy Orchestrator

- Envoy Proxy listens to requests and proxies them to the correct destination

- Fyde Proxy Orchestrator ensures that Envoy Proxy is configured with the correct requests and takes care of requests authorization and authentication

- Fyde Proxy Orchestrator requires a valid token (Fyde Access Proxy enrollment link) that contains the necessary information to bootstrap and authorize the service

## Install

- [Bare Metal / Virtual Machine](proxy/fyde_proxy_bm_vm.md)

- [Docker](proxy/fyde_proxy_docker.md)

- [Kubernetes](proxy/fyde_proxy_kubernetes.md)

## Troubleshoot

- [Troubleshoot](proxy/fyde_proxy_troubleshoot.md)

## Configure

- [Parameters](proxy/fyde_proxy_parameters.md)

## Architecture

- [CPU](proxy/fyde_proxy_req_cpu.md)

- [Network](proxy/fyde_proxy_req_net.md)

## Monitor

- [Prometheus metrics](proxy/fyde_proxy_prometheus.md)

## High availability

- [High availability](proxy/fyde_proxy_ha.md)
