---
layout: default
title: Parameters
parent: Fyde Access Proxy
nav_order: 6
---
# Parameters

## Fyde Envoy Proxy

- Environment variables to override default values:

| Key               | Default Value | Type      | Description                                   |
| ----------------- | ------------- | --------- | --------------------------------------------- |
| COMPONENTLOGLEVEL | grpc:debug,config:debug   | str   | Envoy's component specific log level [info](https://www.envoyproxy.io/docs/envoy/latest/operations/cli#cmdoption-component-log-level){:target="_blank"} |
| FYDE_PROXY_HOST   | proxy-client  | str       | Fyde Orchestrator's hostname / DNS record     |
| FYDE_PROXY_PORT   | 50051         | str       | Fyde Orchestrator's service port              |
| LOGLEVEL          | info          | str       | Envoy's global loglevel [info](https://www.envoyproxy.io/docs/envoy/latest/operations/cli#cmdoption-component-log-level){:target="_blank"}   |

## Fyde Proxy Orchestrator

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
| authz_pubkey              | None          | str   | Authorizer EC Public Key (Used to verify authorization JWTs)          |
| authz_timeout             | 30            | int   | Fyde authorization call timeout (seconds)                             |
| enable_ipv6               | False         | bool  | Enable ipv6 usage for DNS in envoy                                    |
| enrollment_token          | None          | str   | Enrollment token provided by Fyde Enterprise Console                  |
| envoy_listener_port       | 8000          | int   | Envoy General Listener port                                           |
| envoy_prometheus          | True          | bool  | Prometheus metrics for Envoy Proxy status                             |
| envoy_prometheus_port     | 9000          | int   | Prometheus for Envoy Proxy port                                       |
| grpc_insecure             | True          | bool  | gRPC insecure mode for the Fyde Proxy Orchestrator                    |
| grpc_listener             | '[::]:50051'  | str   | gRPC listener for the Fyde Proxy Orchestrator                         |
| http_proxy                | None          | str   | Use HTTP proxy. Example: "http://proxy.host:1234/" or "socks5://10.0.0.1:5555"    |
| https_proxy               | None          | str   | Use HTTPS proxy. Example: "https://proxy.host:1234/" or "socks5://10.0.0.1:5555"  |
| proxy_prometheus          | True          | bool  | Prometheus metrics for Fyde Proxy Orchestrator status                 |
| proxy_prometheus_port     | 9010          | int   | Prometheus for Fyde Proxy Orchestrator port                           |
| redis_ssl                 | False         | bool  | Enable SSL support for Redis connections                              |
| redis_sentinel_ssl        | False         | bool  | Enable SSL support for Redis Sentinel connections                     |
| redis_ssl_cert_reqs       | 'none'        | str   | SSL Certificate verification options. one of 'none', 'optional', 'required'. [More info here](https://docs.python.org/3/library/ssl.html#ssl.SSLContext.verify_mode) |
| redis_ssl_key             | None          | str   | Redis/Sentinel SSL client authentication private key |
|                           |               |       | This can be a path to a file holding the key or the content of it inlined in the variable |
| redis_ssl_cert            | None          | str   | Redis/Sentinel SSL client authentication certificate |
|                           |               |       | This can be a path to a file holding the cert or the content of it inlined in the variable |
| redis_ssl_ca_certs        | None          | str   | Redis/Sentinel SSL CA trusted anchors |
|                           |               |       | This can be a path to a file holding the certs or the content of it inlined in the variable |
| redis_auth                | None          | str   | Redis auth key                                                        |
| redis_db                  | 0             | int   | Redis database                                                        |
| redis_host                | None          | str   | Used for HA mode only, leave empty in Fyde Access Proxy single mode   |
| redis_port                | 6379          | int   | Redis port                                                            |
| redis_timeout             | 1.0           | float | Redis socket_timeout in seconds                                       |
| redis_sentinel_hosts      | None          | str   | Redis Sentinel comma separated list of host:port pairs                |
| redis_sentinel_service_name   | None      | str   | Redis Sentinel service (cluster) name                                 |
| redis_sentinel_wait_for_master    | 30    | int   | Redis Sentinel time in seconds to wait for master                     |
