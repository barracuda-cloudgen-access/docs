---
title: Releases
has_children: false
nav_order: 9
---
# Latest releases

## Fyde App - Version 0.24.0

Release date: 10-02-2020

### Improvements

- Added support for wildcard resources
- Added support for disk encryption, firewall and anti-virus detection policies on Windows
- Improved bug report screen

### Bugfixes

- Fixed a problem on the screen lock policy restriction on macOS
- Fix for all clients: fixed handling of HTTP chunked transfer encoding

## Fyde Enterprise Console - Version 0.10.1

Release date: 10-02-2020

### Improvements

- Added support for resources with wildcard domains and port ranges
- Added password reset flow
- Several bug fixes and performance improvements

## Fyde Cli - Version 0.8.0

Release date: 11-02-2020

_**Deprecation warning**: please upgrade to the newest version as soon as possible since there are API incompatibilities on older ones_

### Improvements

- Adds support for resources with wildcard domains and port ranges
- Add support for specifying several conditions and parameters in several API endpoints
- Several other [improvements](https://github.com/fyde/fyde-cli/releases/tag/v0.8.0).

## Fyde Proxy Orchestrator - Version 1.2.0

Release date: 11-02-2020

_requires envoy 1.13.0: update should be simultaneous_

### Improvements

- Added support for new authorization protocol 3 used for port ranges and wildcard domains
- Changed resource list polling mechanism to daily polls with lazy updates based on requests
- Changed all Redis keys to include the proxy_id so a same Redis cluster can be used for multiple proxies
- Added support for configuring a logfile parameter that copies all logs to it

## Envoy - Version 1.13.0

Release date: 11-02-2020

### Improvements

- Rebased all code to follow upstream 1.13.0
- Added support for debian packaging and alpine docker images
- Added support for new authorization protocol 3 used for wildcard domains
- Fixed Centos build on 1.13.0 (linker was broken on upstream)

## Fyde Deployment Scripts

Added [Cloudformation scripts for proxy deployment]({{ site.baseurl }}{% link fyde-access-proxy/install-aws.md %}).
