---
title: Fyde Proxy Envoy
has_children: false
nav_order: 5
parent: Releases
---
# Fyde Proxy Envoy

## Version 1.13.4.1

Release date: 2020.08.29

- Fix dns_cache crash when domain cannot be resolved

## Version 1.13.4

Release date: 2020.08.26

- backport dns_cache fix from upstream
- Fixes on the release process

## Version 1.13.0

Release date: 2020.02.11

- Rebased all code to follow upstream 1.13.0
- Added support for debian packaging and alpine docker images
- Added support for new authorization protocol 3 used for wildcard domains
- Fixed Centos build on 1.13.0 (linker was broken on upstream)
