---
layout: default
title: Linux
parent: Fyde App
nav_order: 1
---
# Fyde App - Linux

Instructions to install the Fyde App in different distributions.

Fyde App for Linux is distributed in two separate packages:

- fyde - GUI for interactive user sessions (depends on fyde-tunnel)
- fyde-tunnel - standalone network services and command line utilities designed to run in headless setups

Supported versions:

| Distro    | Versions      | Instructions              |
| ---       | ---           | ---                       |
| Arch      | -             | In progress               |
| CentOS    | 7, 8          | [YUM](##yum-repository)   |
| Debian    | 9, 10         | [APT](##apt-repository)   |
| Ubuntu    | 16.04, 18.04  | [APT](##apt-repository)   |
| Other Distribution     | x86_64   | In progress       |

## APT Repository

1. Install pre-requisites

    ```sh
    sudo apt update
    sudo apt install -y apt-transport-https wget gnupg2
    ```

1. Add repository

    ```sh
    REPO_URL="downloads.fyde.com"
    wget -q -O - "https://$REPO_URL/fyde-public-key.asc" | sudo apt-key add -
    sudo bash -c "cat > /etc/apt/sources.list.d/fyde.list <<EOF
    deb https://$REPO_URL/apt stable main
    EOF"
    sudo apt update
    ```

1. Install

    - GUI version

    ```sh
    sudo apt install fyde
    ```

    - CLI version

        - Install

        ```sh
        sudo apt install fyde-tunnel
        ```

        - Enroll

        ```sh
        /opt/fyde/fyde-tunnel --enroll "<Fyde App enrollment link>"
        systemctl --user enable fyde-tunnel
        systemctl --user start fyde-tunnel
        ```

## YUM Repository

1. Install pre-requisites

    ```sh
    sudo yum -y install wget
    ```

1. Add repository

    ```sh
    REPO_URL="downloads.fyde.com"
    sudo yum-config-manager -y --add-repo "https://${REPO_URL}/fyde.repo"
    wget -q -O /tmp/fyde-public-key.asc "https://$REPO_URL/fyde-public-key.asc"
    sudo rpm --import /tmp/fyde-public-key.asc
    rm -v /tmp/fyde-public-key.asc
    ```

1. Install

    - GUI version

    ```sh
    sudo yum install fyde
    ```

    - CLI version

        - Install

        ```sh
        sudo yum install fyde-tunnel
        ```

        - Enroll

        ```sh
        /opt/fyde/fyde-tunnel --enroll "<Fyde App enrollment link>"
        ```

        - Start the tunnel

            - CentOS 7

            ```sh
            /opt/fyde/scripts/systemctl start
            ```

            - CentOS 8+

            ```sh
            systemctl --user start fyde-tunnel
            ```
