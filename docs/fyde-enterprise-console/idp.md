---
layout: default
title: Identity Provider
parent: Fyde Enterprise Console
nav_order: 7
has_children: true
has_toc: false
---

# Identity provider

- Fyde Enterprise Console supports configuring [SAML]({{ site.baseurl }}{% link fyde-enterprise-console/saml.md %}) and [OIDC]({{ site.baseurl }}{% link fyde-enterprise-console/oidc.md %}) as identity providers for enrolling devices.
- By default, all Fyde tenants come configured with an Email-backed internal Identity Provider. This provider requires no configuration and will simply send an email to the configured user email address, with a secure link the user must click, as a form of authentication.
