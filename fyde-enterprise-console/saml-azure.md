---
layout: default
title: Azure AD SAML
parent: SAML Configuration
grand_parent: Fyde Enterprise Console
nav_order: 2
---
# Azure AD SAML

Steps to create an Azure AD SAML application to use with Fyde Enterprise Console

- Note: this configuration requires an [AZURE AD Premium P2 Subscription](https://azure.microsoft.com/en-us/services/active-directory/){:target="_blank"}

- The steps were retrieved from [this tutorial](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/add-application-portal){:target="_blank"}

## Configure SAML

1. Sign in to the [Azure portal](https://portal.azure.com){:target="_blank"} as a global admin for your Azure AD tenant, a cloud application admin, or an application admin

1. Select **Azure Active Directory** - **Enterprise Applications**

    ![Enterprise Applications]({{ site.baseurl }}{% link imgs/ec-saml-azure-enterprise-applications.png %})

1. Select **New application**

    ![New Application]({{ site.baseurl }}{% link imgs/ec-saml-azure-new-application.png %})

1. Select **Non-gallery Application**

    - Insert the desired **Name** (suggestion: Fyde Enterprise Console)

    - Click **Add** to create the application

    ![Create Application]({{ site.baseurl }}{% link imgs/ec-saml-azure-create-application.png %})

1. Select **Single sign-on** and change the method to **SAML**

    ![SSO Method]({{ site.baseurl }}{% link imgs/ec-saml-azure-sso-method.png %})

1. In this menu we are going to use the values obtained from step 2 in [Fyde Enterprise Console SAML]({{ site.baseurl }}{% link fyde-enterprise-console/saml-enterprise-console.md %}):

    - Please fill in:

        - Identifier (Entity ID)

        - Reply URL (Assertion Consumer Service URL)

        - Sign on URL (SSO URL)

    - Click **Save** and close the form with top right **X**

    ![SAML Configuration]({{ site.baseurl }}{% link imgs/ec-saml-azure-configuration.png %})

1. Get the custom application SAML configuration:

    - Please take note of the **Login URL** and the **Azure AD identifier**

    - Click **Download** to get the **Certificate (Base64)**

    ![SAML Properties]({{ site.baseurl }}{% link imgs/ec-saml-azure-provider.png %})

1. Select **Manage** - **Properties**:

    - Ensure **Enabled for users to sign-in?** is enabled

    - [Optional] Use this [image]({{ site.baseurl }}{% link imgs/fyde-logo.png %}){:target="_blank"} to configure the logo for the application

    - We recomend disabling **User assignment required?**, otherwise you need to manually add all the desired users/groups allowed to use the application

    ![SAML Provider]({{ site.baseurl }}{% link imgs/ec-saml-azure-application-properties.png %})

1. Use the values obtained to continue the step 3 configuration in [Fyde Enterprise Console SAML]({{ site.baseurl }}{% link fyde-enterprise-console/saml-enterprise-console.md %}):

    - **Entity ID** -> **Azure AD identifier**

    - **SSO URL** -> **Redirect URL**

    - **Certificate (base64)** -> **Certificate (base64)**
