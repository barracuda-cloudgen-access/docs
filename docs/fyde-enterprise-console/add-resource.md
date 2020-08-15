---
layout: default
title: Add resource
parent: Fyde Enterprise Console
nav_order: 6
---
# Add resource

To add a new resource, go to **Access** and click the **“+”** icon in the top right.

![Control Screen]({{ site.baseurl }}{% link imgs/ec-access-resources.png %})

Fill in the details:

![Add Resource]({{ site.baseurl }}{% link imgs/ec-access-add-resource.png %})

- **Resource Name**: Simple identifier for the resource in Fyde Enterprise Console

- **Public Host**: Hostname used by the device to redirect the request to the Fyde Access Proxy
  - Needs to be a valid DNS record
  - Doesn’t need to exist as a public DNS record, private or at all

- **Resource Host**: Internal resource hostname or IP used by the Fyde Access Proxy to connect to
  - Needs to be a hostname or IP that the Fyde Access Proxy can resolve and connect to

- **External Port**: Port used for the request to the Public Host from the device

- **Internal Port**: Internal Resource port used by the Fyde Access Proxy to connect to the Resource Host

- **Access Proxy**: The Fyde Access Proxy that will be used and has access to the resource being configured

- **Policy Name**: The policy used to allow access for this resource

- **Notes**: Can be used to add extra information regarding the resource

Please note:

- When accessing an internal resource with HTTPS configured, the **Public Host** needs to match the configured hostname in the resource certificate
