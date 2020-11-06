---
layout: default
title: OIDC Configuration
parent: Identity Provider
grand_parent: Fyde Enterprise Console
nav_order: 5
has_children: false
has_toc: false
---

# OIDC Configuration

1. To configure OIDC, go to **Settings**, then  **General**, **Identity Provider**,
click **Activate Provider** and then click on your OpenID Connect choice.

    ![Console Settings]({{ site.baseurl }}{% link imgs/ec-idp-enterprise-console-settings-button.png %})

## Google OpenID Connect

When choosing this option, there are no additional steps to configure.
The identity provider is now configured.

## Microsoft OpenID Connect

When choosing this option, write a comma separated list of all Microsoft Azure AD Tenant IDs you wish to use for SSO.

Each Tenant ID will become a link once you accept the form. An Azure Administrator must click on each of these links to grant Administrator Consent to our OpenID Connect Authenticator app.

## Custom OpenID Connect

1. Please take note of the fields your provider will require:

    - Client ID

    - Client secret

    - Metadata URL

    - Email Claim

    ![Console Settings]({{ site.baseurl }}{% link imgs/ec-oidc-config-modal.png %})

Refer to your Identity Provider configuration manual on how to retrieve these configuration values.