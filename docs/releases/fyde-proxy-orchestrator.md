---
title: Fyde Proxy Orchestrator
has_children: false
nav_order: 4
parent: Releases
---
# Fyde Proxy Orchestrator

## Version 1.3.3

Release date: 2020.09.13

- Pyinstaller Folder Refresher

## Version 1.3.2

Release date: 2020.08.29

**NOTE**: requires envoy 1.13.4.0 or later: update should be simultaneous

- Fixes Envoy version parsing

## Version 1.2.2

Release date: 2020.08.18

- Add support for configurable TCP Keepalive both on upstream and downstream sockets

## Version 1.2.0

Release date: 2020.02.11

**NOTE**: requires envoy 1.13.0: update should be simultaneous

- Added support for new authorization protocol 3 used for port ranges and wildcard domains
- Changed resource list polling mechanism to daily polls with lazy updates based on requests
- Changed all Redis keys to include the proxy_id so a same Redis cluster can be used for multiple proxies
- Added support for configuring a logfile parameter that copies all logs to it

## Version 1.1.12

Release date: 2020.01.15

- Added support for TLS Session Tickets in cluster mode
- Added support for HTTP/S Proxies
- Bugfix for AWS detection feature
