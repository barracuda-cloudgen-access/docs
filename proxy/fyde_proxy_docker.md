# Install Fyde Proxy in Docker

- The required images are available in Dockerhub registry under the organization [FydeInc](https://hub.docker.com/u/fydeinc)

- Instalation requires a valid [Proxy Enrollment Link](../console/configurations/add_proxy.md#adding-a-proxy)

- Tested in:
  - Debian 9
  - Centos 7
  - Ubuntu 16.04/18.04

- Choose [**Install script**](##install-script) or [**Manual steps**](##manual-steps) to proceed

## Install script

- Please note that the steps below will execute scripts obtained externally

- We advise to inspect the content before execution

1. Download and execute script

    ```sh
    sudo bash -c "$(curl -fsSL https://url.fyde.me/install-fyde-proxy-docker)"
    ```

## Manual steps

### Pre-requisites

- [Docker](https://www.docker.com/get-started) (version 18.02.0+)

- [Docker Compose](https://docs.docker.com/compose/install/) (version 1.21.0+)

### Docker Compose

1. Create the docker compose file

    - Download the docker-compose file definition:

        - [docker/docker-compose.yml](docker/docker-compose.yml)

    - Make sure configured port matches the one configured in the Management Console

    - Update `FYDE_ENROLLMENT_TOKEN` value with `Proxy Enrollment Link`

1. Start the services (detached)

    ```sh
    sudo docker-compose -f docker-compose.yml up -d
    ```

1. Check logs

    ```sh
    sudo docker-compose -f docker-compose.yml logs -f
    ```
