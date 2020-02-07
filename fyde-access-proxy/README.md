---
layout: default
title: Fyde Access Proxy
has_children: true
nav_order: 5
permalink: /fyde-access-proxy
---
# Fyde Access Proxy
{: .no_toc }

Fyde Access Proxy is the software combo that contains two services: Envoy Proxy and Fyde Proxy Orchestrator.

 Envoy Proxy listens to requests and proxies them to the correct destination. Fyde Proxy Orchestrator ensures that Envoy Proxy is configured with the correct requests and is responsible for requests authorization and authentication.

Fyde Proxy Orchestrator requires a valid token (Fyde Access Proxy enrollment link) that contains the necessary information to bootstrap and authorize the service. You can obtain the enrollment link by registering the proxy in the Fyde Enterprise Console.

Envoy Proxy requires connectivity to internal/protected resources and to have an outbound open port, which is configured in the console. This port is used only for the clients to connect to (the Fyde app that runs on the devices). The Proxy Orchestrator communicates with the Enterprise Console for obtaining policies (control plane).

As a rule of thumb, a Fyde Access Proxy (possibly with high availability) should be deployed per network/VLAN. Proxies should be deployed as close as possible to resources that they serve, in order to maximize security and performance.

Please check the links for more information on installation instructions, networking, troubleshooting and high availability setup.
