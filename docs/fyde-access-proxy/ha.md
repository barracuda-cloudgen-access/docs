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

- Redis Replication is out of the scope of this document

- Please check [Redis Replication](https://redis.io/topics/replication){:target="_blank"}
