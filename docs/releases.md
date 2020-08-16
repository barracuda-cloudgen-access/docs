---
title: Releases
has_children: false
nav_order: 9
---
# Latest releases

## Fyde App - Version 0.24.0

Release date: 13-05-2020

- Added option to reset activity
- Several improvements and bugfixes

## Fyde Enterprise Console - Version 0.10.14

Release date: 10-05-2020

- Several bug fixes and performance improvements

## Fyde Cli - Version 0.9.1

Release date: 5-05-2020

- Added support for SSO login
- Added admin management support (list, create, edit, delete)
- Added support to set a different email for administrators SSO authentication

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

Release date: 27-05-2020

- Several fixes.
- Added [Cloudformation scripts for proxy deployment]({{ site.baseurl }}{% link fyde-access-proxy/install-aws.md %}).

## Fyde Directory Connector - Version 1.3.0

Release date: 1-06-2020

- AD support improvements

