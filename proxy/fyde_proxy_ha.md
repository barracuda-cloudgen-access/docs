# Fyde Access Proxy high availability

- Multiple instances of each component (Envoy Proxy and Fyde Proxy Orchestrator) can be executed n times to increase availability of the services

- This mode requires a redis instance available from all the Fyde Proxy Orchestrator instances. The redis instance is used to:

  - share cache authorization status

  - cache the list of resources to decrease API requests and increase performance

- Redis settings are configured with the respective `redis_` keys (check [Parameters](./fyde_proxy_parameters.md))

- Please check the [Network](./fyde_proxy_req_net.md) requirements for load balancer information and diagram

- NOTE: Redis Replication is out of the scope for this document

  - Please check `https://redis.io/topics/replication`
