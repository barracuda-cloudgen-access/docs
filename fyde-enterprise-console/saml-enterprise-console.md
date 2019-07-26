---
layout: default
title: Fyde Enterprise Console SAML
parent: SAML Configuration
grand_parent: Fyde Enterprise Console
nav_order: 1
---
# Fyde Enterprise Console SAML

- These are the common steps required to configure SAML authentication for enrolling devices

## Configure SAML

1. To configure SAML, go to **Settings**, then  **General**, **SAML** and click **Activate**

    ![Console Settings]({{ site.baseurl }}{% link imgs/ec-saml-enterprise-console-settings-button.png %})

1. Please take note of the fields your provider will require:

    - Identifier (Entity ID)

    - Assertion Consumer Service URL

    - SSO URL

    ![Console Settings]({{ site.baseurl }}{% link imgs/ec-saml-enterprise-console-settings-menu.png %})

1. Follow one of the [provider specific]({{ site.baseurl }}{% link fyde-enterprise-console/saml.md %}#provider-specific) steps to obtain the required fields:

    - Entity ID

    - Redirect URL (SSO URL)

    - Certificate
