---
layout: default
title: SAML Configuration
parent: Identity Provider
grand_parent: Fyde Enterprise Console
nav_order: 1
has_toc: false
---
# SAML Configuration

- SAML authentication can be configured for enrolling devices through a specific identity provider.

## Configure SAML

1. To configure SAML, go to **Settings**, then  **General**, **Identity Provider**,
click **Activate Provider** and then **SAML 2.0**.

    ![Console Settings]({{ site.baseurl }}{% link imgs/ec-idp-enterprise-console-settings-button.png %})

1. Please take note of the fields your provider will require:

    - Identifier (Entity ID)

    - Assertion Consumer Service URL

    - SSO URL

    ![Console Settings]({{ site.baseurl }}{% link imgs/ec-saml-enterprise-console-settings-menu.png %})

1. Follow one of the [provider specific](#provider-specific) steps to obtain the required fields:

    - Entity ID

    - Redirect URL (SSO URL)

    - Certificate

## Provider Specific Steps

- [Azure AD]({{ site.baseurl }}{% link fyde-enterprise-console/saml-azure.md %})

- [Google Suite]({{ site.baseurl }}{% link fyde-enterprise-console/saml-gsuite.md %})

- [Okta]({{ site.baseurl }}{% link fyde-enterprise-console/saml-okta.md %})
