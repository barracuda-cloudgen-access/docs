# Fyde Proxy in Docker

- Pre-requisites:

  - [Docker](https://www.docker.com/get-started) (version 18.02.0+)

  - [Docker Compose](https://docs.docker.com/compose/install/) (version 1.21.0+)

  - [Proxy Enrollment Link](../console/configurations/add_proxy.md#adding-a-proxy)

- The required images are available in Dockerhub registry under the organization [FydeInc](https://hub.docker.com/u/fydeinc)

## Docker Compose

1. Create the docker compose file

    - Download the docker-compose file definition:

        - [docker/docker-compose.yml](docker/docker-compose.yml)

    - Make sure configured port matches the one configured in the Management Console

    - Update `FYDE_ENROLLMENT_TOKEN` value with `Proxy Enrollment Link`

1. Start the services (detached)

    ```sh
    docker-compose -f docker-compose.yml up -d
    ```

1. Check logs

    ```sh
    docker-compose -f docker-compose.yml logs -f
    ```
