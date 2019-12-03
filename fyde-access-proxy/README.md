---
layout: default
title: Fyde Access Proxy
has_children: true
nav_order: 5
permalink: /fyde-access-proxy
---
# Fyde Access Proxy
{: .no_toc }

Fyde Access Proxy is the software combo that contains Envoy Proxy and Fyde Proxy Orchestrator.

 Envoy Proxy listens to requests and proxies them to the correct destination. Fyde Proxy Orchestrator ensures that Envoy Proxy is configured with the correct requests and is responsible for requests authorization and authentication.

- Fyde Proxy Orchestrator requires a valid token (Fyde Access Proxy enrollment link) that contains the necessary information to bootstrap and authorize the service. You can obtain the enrollment link by registering the proxy in the Fyde Enterprise Console.

Please check the links for installation instructions, troubleshooting and high availability setup.
