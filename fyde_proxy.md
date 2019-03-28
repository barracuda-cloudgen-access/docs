# Fyde Proxy

## Requirements

- [CPU](proxy/fyde_proxy_req_cpu.md)

- [Network](proxy/fyde_proxy_req_net.md)

## Configure

- These keys are applicable to the Proxy Client

- The following override mechanisms will be processed in order, the last override representing the final value:

  1) default value
  1) configuration pushed from Fyde Enterprise Console
  1) overrides.json file on the CWD of the service process
  1) Docker provisioned secret (/run/secrets/\<key>)
  1) AWS SSM (all keys prefixed with 'fyde_')
  1) AWS SecretsManager (all keys prefixed with 'fyde_')
  1) environment variable, prefixed with FYDE_ and all caps

| Key                       | Default Value | Type  | Description                                                         |
| ------------------------- | ------------- | ----- | ------------------------------------------------------------------- |
| enrollment_token          | None          | str   | Enrollment token provided by the Fyde Enterprise Console            |
| api_ca_validation         | True          | bool  | Verify CA chain on TLS connection to Fyde Infra                     |
| mtls_ca_validation        | True          | bool  | Require and check client certificates belong to a given trusted CA  |
| envoy_disable_authz       | False         | bool  | Disable calling our APE authorization system from Envoy Proxy       |
| envoy_disable_rscs_healthcheck  | False   | bool  | Disable resources healthcheck                                       |
| fyde_authz_timeout        | 5             | int   | Fyde authorization call timeout (seconds)                           |
| forced_authz_response     | None          | bool  | Force an authz response (True: allow, False: denied)                |
| disable_authz_cache       | False         | bool  | Disable authentication cache                                        |
| authz_cache_positive_ttl  | 30            | int   | Authentication cache TTL (seconds)                                  |
| authz_cache_negative_ttl  | 5             | int   | Currently it represents the proxy certificates that Envoy requires  |
| redis_host                | None          | str   | Used for HA mode only, leave empty in Proxy Client single mode      |
| redis_port                | 6379          | int   | redis port                                                          |
| redis_auth                | None          | str   | redis auth key                                                      |
| redis_db                  | 0             | int   | redis database                                                      |
| grpc_insecure             | True          | bool  | gRPC insecure mode for the Proxy Client                             |
| grpc_listener             | '[::]:50051'  | str   | gRPC listener for the Proxy Client                                  |
| envoy_prometheus          | True          | bool  | Prometheus metrics for Envoy Client status                          |
| envoy_prometheus_port     | 9000          | int   | Prometheus for Envoy Client port                                    |
| proxy_prometheus          | True          | bool  | Prometheus metrics for Proxy Client status                          |
| proxy_prometheus_port     | 9010          | int   | Prometheus for Proxy Client port                                    |

## Install

Note: all instalations require a valid [Proxy Enrollment Link](./console/exercises/add_proxy.md#adding-a-proxy)

- [Bare Metal / Virtual Machine](proxy/fyde_proxy_bm_vm.md)

- [Docker](proxy/fyde_proxy_docker.md)

- [Kubernetes](proxy/fyde_proxy_kubernetes.md)

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
