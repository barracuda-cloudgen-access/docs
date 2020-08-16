---
layout: default
title: Fyde App
has_children: true
nav_order: 3
permalink: /fyde-app
---
# Fyde App
{: .no_toc }

The Fyde app bundles the end user UI and the Fyde Agent. It is available on the following platforms:

* [iOS](https://www.fyde.com/downloads/ios){:target="_blank"}
* [Android](https://www.fyde.com/downloads/android){:target="_blank"}
* [MacOS](https://www.fyde.com/downloads/macos){:target="_blank"}
* [Windows](https://www.fyde.com/downloads/windows){:target="_blank"}
* [Linux]({{ site.baseurl }}{% link fyde-app/linux.md %})

## Fyde Agent

The Fyde Agent intercepts requests at the network layer. When a DNS request matches a protected resource, it injects a reply, pointing the domain to an internally accessible marker IP address that represents the resource. It then, in parallel, initiates a request to the Access Policy Engine to grant permission to the resource, and establishes an mTLS connection to the Access Proxy that is associated with the resource.

The Fyde Agent also includes a DNS security engine that blocks requests that match blacklists configured at the Enterprise Console level.

## Fyde App UI

Besides configuration and enrollment, the Fyde app UI has two main responsibilities:

1. guide the user through remediations to be able to access a resource and
2. provide a friendly UX for blocked DNS resources.

Both flows start with a notification that is triggered when the user either tries to access a resource without fully complying with the corresponding policy, or when the user tries to access a blocked domain.
