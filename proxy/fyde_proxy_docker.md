# Install Fyde Proxy in Docker

- The required images are available in Dockerhub registry under the organization [FydeInc](https://hub.docker.com/u/fydeinc)

- Choose **Install script** or **Manual steps** to proceed

## Install script

- Please note that the steps below will execute scripts obtained externally
- We advise to inspect the content before execution

1. Download and execute script

    ```sh
    curl -fsSL https://raw.githubusercontent.com/fydeinc/docs/master/proxy/docker/install-fyde-proxy-docker.sh \
        -o install-fyde-proxy-docker.sh
    sudo bash install-fyde-proxy-docker.sh
    ```

- Tested in:
  - Ubuntu 16.04
  - Centos 7

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
