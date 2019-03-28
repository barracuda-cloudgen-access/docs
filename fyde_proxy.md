# Fyde Proxy

## Requirements

- [CPU](proxy/fyde_proxy_req_cpu.md)

- [Network](proxy/fyde_proxy_req_net.md)

## Install

Note: all instalations require a valid [Proxy Enrollment Link](./console/exercises/add_proxy.md#adding-a-proxy)

- [Bare Metal / Virtual Machine](proxy/fyde_proxy_bm_vm.md)
- [Docker](proxy/fyde_proxy_docker.md)
- [Kubernetes](proxy/fyde_proxy_kubernetes.md)

## Configure

- [Parameters](proxy/fyde_proxy_parameters.md)

## Monitor

- [Prometheus metrics](proxy/fyde_proxy_prometheus.md)

## High Available mode

- Multiple instances of each component (Envoy Proxy and Fyde Client ) can be executed simultaneously to increase availability of the services
- This mode requires a redis instance available from all the Proxy Clients. The instance is used to:
  - share cache authorization status
  - cache the list of resources to decrease API requests and increase performance
- Redis settings are configured with the respective `redis_` keys (check [Parameters](proxy/fyde_proxy_parameters.md))
- Please check the [Network](proxy/fyde_proxy_req_net.md) requirements for load balancer information and diagram
- NOTE: Redis Replication is out of the scope for this document
  - Please check `https://redis.io/topics/replication`
