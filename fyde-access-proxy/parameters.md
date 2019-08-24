---
layout: default
title: Parameters
parent: Fyde Access Proxy
nav_order: 5
---
# Parameters

- These keys are applicable to the Fyde Proxy Orchestrator

- The following override mechanisms will be processed in order, the last override representing the final value:

  1. default value
  1. configuration pushed from Fyde Enterprise Console
  1. overrides.json file on the CWD of the service process
  1. Docker provisioned secret (/run/secrets/\<key>)
  1. AWS SSM (all keys prefixed with 'fyde_')
  1. AWS SecretsManager (all keys prefixed with 'fyde_')
  1. environment variable, prefixed with FYDE_ and all caps

| Key                       | Default Value | Type  | Description                                                           |
| ------------------------- | ------------- | ----- | --------------------------------------------------------------------- |
| accept_any_authz_token    | False         | bool  | Accept any JWT auth tokens (no signature check)                       |
| api_ca_validation         | True          | bool  | Verify CA chain on TLS connection to Fyde Infra                       |
| authz_cache_negative_ttl  | 5             | int   | Authentication cache TTL (seconds)                                    |
| authz_cache_positive_ttl  | 30            | int   | Authentication cache TTL (seconds)                                    |
| authz_pubkey              | None          | str   | Authorizer EC Public Key (Used to verify authorization JWTs)          |
| authz_timeout             | 30            | int   | Fyde authorization call timeout (seconds)                             |
| forced_authz_response     | None          | bool  | Force an authz response (True: allow, False: denied)                  |
| disable_authz_cache       | False         | bool  | Disable authentication cache                                          |
| enrollment_token          | None          | str   | Enrollment token provided by Fyde Enterprise Console                  |
| envoy_listener_port       | 8000          | int   | Envoy General Listener port                                           |
| envoy_prometheus          | True          | bool  | Prometheus metrics for Envoy Proxy status                             |
| envoy_prometheus_port     | 9000          | int   | Prometheus for Envoy Proxy port                                       |
| envoy_secrets             | None          | dict  | Currently it represents the proxy certificates that Envoy requires    |
| grpc_insecure             | True          | bool  | gRPC insecure mode for the Fyde Proxy Orchestrator                    |
| grpc_listener             | '[::]:50051'  | str   | gRPC listener for the Fyde Proxy Orchestrator                         |
| mtls_ca_validation        | True          | bool  | Require and check client certificates belong to a given trusted CA    |
| proxy_prometheus          | True          | bool  | Prometheus metrics for Fyde Proxy Orchestrator status                 |
| proxy_prometheus_port     | 9010          | int   | Prometheus for Fyde Proxy Orchestrator port                           |
| redis_auth                | None          | str   | Redis auth key                                                        |
| redis_db                  | 0             | int   | Redis database                                                        |
| redis_host                | None          | str   | Used for HA mode only, leave empty in Fyde Access Proxy single mode   |
| redis_port                | 6379          | int   | Redis port                                                            |
| redis_timeout             | 1.0           | float | Redis socket_timeout in seconds                                       |
| redis_sentinel_hosts      | None          | str   | Redis Sentinel comma separated list of host:port pairs                |
| redis_sentinel_service_name   | None      | str   | Redis Sentinel service (cluster) name                                 |
| redis_sentinel_wait_for_master    | 30    | int   | Redis Sentinel time in seconds to wait for master                     |
