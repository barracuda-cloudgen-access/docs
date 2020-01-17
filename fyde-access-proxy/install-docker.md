---
layout: default
title: Install in Fyde Access Proxy in Docker
parent: Fyde Access Proxy
nav_order: 2
---
# Install in Docker

- Minimum OS supported versions:
  - Debian 9
  - Centos 7
  - Ubuntu 16.04
  - MacOS 10.14

- The required images are available in Dockerhub registry under the organization [FydeInc](https://url.fyde.me/docker){:target="_blank"}

- Requires a valid [Fyde Access Proxy enrollment link]({{ site.baseurl }}{% link fyde-enterprise-console/add-fyde-access-proxy.md %}#adding-a-proxy)

- Choose [**Install script**](#install-script) or [**Manual steps**](#manual-steps) to proceed

## Install script

- Please note that the steps below will execute scripts obtained externally

- We advise to inspect the content before execution

1. Download and execute script

    ```sh
    sudo bash -c "$(curl -fsSL https://url.fyde.me/install-fyde-proxy-docker)"
    ```

## Manual steps

### Pre-requisites

- [Docker](https://www.docker.com/get-started){:target="_blank"} (version 18.02.0+)

- [Docker Compose](https://docs.docker.com/compose/install/){:target="_blank"} (version 1.21.0+)

### Docker Compose

1. Create the docker compose file

    - Download the docker-compose file: [docker-compose.yml]({{ site.baseurl }}{% link /fyde-access-proxy/docker/docker-compose.yml %}){:target="_blank"}

    - Ensure that configured host port for envoy matches the one configured in Fyde Enterprise Console for the corresponding Fyde Access Proxy

    - Update **FYDE_ENROLLMENT_TOKEN** value with Fyde Access Proxy enrollment link

1. Start the services (detached)

    ```sh
    sudo docker-compose -f docker-compose.yml up -d
    ```

1. Check logs

    ```sh
    sudo docker-compose -f docker-compose.yml logs -f
    ```

## Troubleshoot

- For troubleshooting steps please visit: [Troubleshooting]({{ site.baseurl }}{% link fyde-access-proxy/troubleshoot.md %})
