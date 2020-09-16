---
title: Fyde Proxy Orchestrator
has_children: false
nav_order: 4
parent: Releases
---
# Fyde Proxy Orchestrator

## Version 1.2.0

Release date: 11-02-2020

**NOTE**: requires envoy 1.13.0: update should be simultaneous

### Improvements

- Added support for new authorization protocol 3 used for port ranges and wildcard domains
- Changed resource list polling mechanism to daily polls with lazy updates based on requests
- Changed all Redis keys to include the proxy_id so a same Redis cluster can be used for multiple proxies
- Added support for configuring a logfile parameter that copies all logs to it

## Version 1.1.12

Release date: 15-01-2020

### Improvements

- Added support for TLS Session Tickets in cluster mode
- Added support for HTTP/S Proxies

### Bug Fixes

- Bugfix for AWS detection feature
