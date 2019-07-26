---
layout: default
title: High Availability
parent: Fyde Access Proxy
nav_order: 9
---
# Fyde Access Proxy high availability

- Multiple instances of each component (Envoy Proxy and Fyde Proxy Orchestrator) can be executed n times to increase availability of the services

- This mode requires a redis instance available from all the Fyde Proxy Orchestrator instances. The redis instance is used to:

  - share cache authorization status

  - cache the list of resources to decrease API requests and increase performance

- Redis settings are configured with the respective `redis_` keys (check [Parameters]({{ site.baseurl }}{% link fyde-access-proxy/parameters.md %}))

- Please check the [Network]({{ site.baseurl }}{% link fyde-access-proxy/req-net.md %}) requirements for load balancer information and diagram

- NOTE: Redis Replication is out of the scope for this document

  - Please check `https://redis.io/topics/replication`
