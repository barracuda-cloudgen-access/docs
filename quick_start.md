# Quick Start

- Follow these steps to perform the required configuration to access a resource protected by Fyde Access Proxy

## Steps

1. [Add new Fyde Access Proxy](#add-new-fyde-access-proxy)

    - Fyde Access Proxy is the software combo that contains Envoy Proxy and Fyde Proxy Orchestrator

    - Envoy Proxy listens to requests and proxies them to the correct destination

    - Fyde Proxy Orchestrator ensures that Envoy Proxy is configured with the correct requests and takes care of requests authorization and authentication

    - Fyde Proxy Orchestrator requires a valid token (Fyde Access Proxy enrollment link) that contains the necessary information to bootstrap and authorize the service

1. [Install Fyde Access Proxy in Docker](#install-fyde-access-proxy-in-docker)

    - In this quick start we recomend installing the solution using the docker infrastructure, for other platforms please visit [Fyde Access Proxy - Install steps](fyde_access_proxy.md##install)

    - The public port will need to be available for the clients connecting to resources

1. [Add new resource](#add-new-resource)

    - In this step we are going to create a test resource, however you can use an existing resource of your own instead

1. [Add new user](#add-new-user)

    - In order to register a device, we need to create a user

    - Please note that users and account administrators are separate entities. The same email can be used for an account administrators and a regular user and there will be no relation between them

1. [Enroll a device](#enroll-a-device)

    - A user can have multiple devices, this will be determined by the account administrators

    - In this step we enroll a new device

1. [Access created resource](#access-created-resource)

    - The enrolled device will now access the created resource

1. [Troubleshoot](#troubleshoot)

    - If the device is not accessing the resource we provide these troubleshooting steps

## Add new Fyde Access Proxy

- To add a Fyde Access Proxy, go to the **Access tab** and navigate to the **Access Proxies**. Click the **“+”** icon in the top right

- This proxy will be used to test an access for the test resource, however this doesn't prevent it from being used as a permanent proxy later on

    ![Control Screen](console/configurations/imgs/access_proxies.png)

- Add the following:

- **Proxy Name**: Used to identify the proxy
- **Location**: Optional, for your reference only
- **Host**: IP/DNS record used to reach the proxy
- **Port**: Port where the Fyde Access Proxy will be available

- Click **Create**

    ![Add Fyde Access Proxy](console/configurations/imgs/access_add_proxy.png)

- Copy the link that will be used when configuring the proxy

- Please Note: This is the only time the link is provided by the Management Console

    ![Add Fyde Access Proxy 2](console/configurations/imgs/access_add_proxy2.png)

## Install Fyde Access Proxy in Docker

- The required images are available in Dockerhub registry under the organization [FydeInc](https://url.fyde.me/docker)

- Requires a valid Fyde Access Proxy enrollment link, obtained in the previous step

- Tested in:
  - Debian 9
  - Centos 7
  - Ubuntu 16.04/18.04

- Please note that the steps below will execute scripts obtained externally

- We advise to inspect the content before execution

- Choose yes, when questioned about installing the test resource

- Download and execute installation script

    ```sh
    sudo bash -c "$(curl -fsSL https://url.fyde.me/install-fyde-proxy-docker)"
    ```

## Add new resource

- To add a new resource, go to **Access tab** and click the **“+”** icon in the top right

    ![Control Screen](console/configurations/imgs/access_resources.png)

- Fill in the details:

    ![Add Resource](console/configurations/imgs/access_add_resource.png )

- **Resource Name**: HTTP Test

- **Public Host**: http.test.local

- **Resource Host**: httptest

- **External Port**: 81

- **Internal Port**: 80

- **Access Proxy**: Select the existing Fyde Access Proxy

- **Policy Name**: Allow Everyone

- **Notes**: Leave empty

## Add new user

- To add a new user, go to **Control tab** and Click the **“+”** icon in the top right

    ![Control Screen](console/configurations/imgs/control_users.png)

- Add the following:

- **Name**: Name to identify the user
- **Email**: Required to send the enrollment to the user link via email
- **Phone**: Optional, for your reference only
- **Group**: Optional, groups that the user is part of

- Click **Create**

    ![Add User](console/configurations/imgs/control_add_user.png)

## Enroll a device

- Enroll a new device for the created user by acessing the enrollment link
  - The link is sent to the email configured for the user or by sharing the link from the user details

- The enrollment process is done directly from the created user's device

## Access created resource

- Access the configured resource by visiting the following link from the enrolled device:

  - <http://http.test.local:81>

## Troubleshoot

- For troubleshooting steps please visit: [Troubleshooting](./proxy/fyde_proxy_troubleshoot.md)
