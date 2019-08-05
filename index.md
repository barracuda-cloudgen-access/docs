---
layout: default
title: Home
nav_order: 1
---
# Overview

Welcome to Fyde! Fyde brings Zero Trust/BeyondCorp Security to the endpoint. In short, with Fyde, you can implement secure access to enterprise resources, whether they are on-prem or in the cloud, with a quick and easy configuration process.

Fyde has three main components: an agent (Fyde App), a proxy (Fyde Access Proxy), and an administration console (Fyde Enterprise Console). It is very simple to start using Fyde: register a proxy and invite your employees to install Fyde App. Check our [Quick Start]({{ site.baseurl }}{% link quickstart.md %}) to know more details.

## About Zero Trust

The days of the VPN are gone: it is no longer feasible to establish a secure network perimeter with a hybrid setup with cloud resources and the myriad of devices that need to access company resources from anywhere. One single breach on a VPN setup can be catastrophic depending on the network setup and configuration.

Zero Trust builds upon the assertion that the network is assumed to be hostile. In consequence, network locality is not sufficient for establishing trust and every flow must be authenticated and authorized in a dynamic fashion. This creates an effective separation between the _control plane_ -- the supporting system that implements the flow authentication and authorization according to the defined policies -- and the _data plane_.

To learn more about Zero Trust, check [Zero Trust Networks: Building Secure Systems in Untrusted Networks](https://www.amazon.com/Zero-Trust-Networks-Building-Untrusted/dp/1491962194){:target="_blank"} and the [BeyondCorp paper by Google](https://storage.googleapis.com/pub-tools-public-publication-data/pdf/43231.pdf){:target="_blank"}

## Architecture overview

As mentioned above, the Fyde architecture relies on three main components: an agent (Fyde App), a proxy (Fyde Access Proxy), and an administration console (Fyde Enterprise Console). The Fyde agent operates at the network layer. When a device starts a connection to a protected resource, the Fyde agent intercepts it and opens a mTLS connection with the Fyde Access Proxy, sending also the device and user attributes. The Fyde Access Proxy will check the attributes and authorize or deny the connection to the resource. To configure policies, you can use the Fyde Enterprise Console.

![Architecture]({{ site.baseurl }}{% link imgs/fyde-architecture.png %})

## Use cases

With Fyde, you can:

* Immediately replace your VPN(s)
* Implement multi-cloud access
* Enable and disable access, on a per-user or per-device level
* Implement policies to protect resources according to criticality level
* Get visibility on traffic flows to resources for auditing purposes

## Next steps

To start using Fyde, check our [Quick Start]({{ site.baseurl }}{% link quickstart.md %}).
