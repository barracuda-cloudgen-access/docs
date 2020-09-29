---
layout: default
title: Install in Bare Metal / Virtual Machine
parent: Fyde Access Proxy
nav_order: 2
---
# Install in Bare Metal / Virtual Machine
{: .no_toc }

## Table of contents
{: .no_toc }
- TOC
{:toc}

## Description

- Minimum OS supported versions:
  - CentOS 7
  - RHEL 8

- Debian / Ubuntu steps coming soon

- Requires a valid [Fyde Access Proxy enrollment link]({{ site.baseurl }}{% link fyde-enterprise-console/add-fyde-access-proxy.md %}#adding-a-proxy)

- Choose [**Install script**](#install-script) or [**Manual steps**](#centos-rhel---manual-steps) to proceed

## Install script

- The steps below will execute a script obtained externally, we advise to inspect the content before execution

- The script will install and enable chrony service for time synchronization, required to ensure tokens are validated properly

- Download and execute installation script

    ```sh
    sudo bash -c "$(curl -fsSL https://url.fyde.me/install-fyde-proxy-linux)"
    ```

- This script can also be used for unnatended instalations

    ```sh
    curl -fsSLo install-fyde-proxy-linux.sh https://url.fyde.me/install-fyde-proxy-linux
    chmod +x install-fyde-proxy-linux.sh
    ./install-fyde-proxy-linux.sh -h
    ```

    ```txt
    Install Fyde Access Proxy script

    Available parameters:
      -h        - Show this help
      -l string - Loglevel (debug, info, warning, error, critical), defaults to info.
      -n        - Don't start services after install
      -p int    - Specify public port (1-65535), required for unattended instalation
      -r string - Specify Redis host to use for token cache <only required for HA architecture>
      -s int    - Specify Redis port <optional>
      -t token  - Specify Fyde Access Proxy token
      -u        - Unattended install, skip requesting input <optional>

    Example for unattended instalation with Fyde Access Proxy token:
      - Specify the Fyde Access Proxy token inside quotes

      ./install-fyde-proxy-linux.sh -p 443 -t "https://xxxxxxxxxxxx" -u

    Example for unattended instalation with Fyde Access Proxy token with Redis endpoint:
      - Specify the Fyde Access Proxy token inside quotes

      ./install-fyde-proxy-linux.sh -p 443 -t "https://xxxxxxxxxxxx" -u -r localhost -s 6379

    Example for unattended instalation, skipping services start, without Fyde Access Proxy token:
      - The token can also be obtained automatically via AWS SSM/Secrets Manager
      - More info: https://fyde.github.io/docs/fyde-access-proxy/parameters/#fyde-proxy-orchestrator

      ./install-fyde-proxy-linux.sh -n -p 443 -u
    ```

## CentOS/RHEL - Manual steps

1. Install pre-requisites

    ```sh
    sudo yum -y install yum-utils chrony
    ```

1. Ensure chrony daemon is enabled on system boot and started

    ```sh
    sudo systemctl enable chronyd
    sudo systemctl start chronyd
    ```

1. Ensure time synchronization is enabled

    ```sh
    sudo timedatectl set-ntp on
    ```

1. Add Fyde repository

    ```sh
    sudo yum-config-manager -y --add-repo https://downloads.fyde.com/fyde.repo
    ```

1. Install Envoy Proxy

    ```sh
    sudo yum -y install envoy
    sudo systemctl enable envoy
    ```

1. Add CAP_NET_BIND_SERVICE to Envoy using a service unit override

    If you choose to configure your proxy to run in a port below 1024,
    you will need to add the CAP_NET_BIND_SERVICE capability to Envoy.

    ```sh
    sudo mkdir -p /etc/systemd/system/envoy.service.d

    sudo bash -c "cat > /etc/systemd/system/envoy.service.d/10-add-cap-net-bind.conf <<EOF
    [Service]
    Capabilities=CAP_NET_BIND_SERVICE+ep
    CapabilityBoundingSet=CAP_NET_BIND_SERVICE
    AmbientCapabilities=CAP_NET_BIND_SERVICE
    SecureBits=keep-caps
    EOF"

    sudo chmod 600 /etc/systemd/system/envoy.service.d/10-add-cap-net-bind.conf
    ```

1. Reload and start Envoy Proxy

    ```sh
    sudo systemctl --system daemon-reload
    sudo systemctl start envoy
    ```

1. Install Fyde Proxy Orchestrator and authz system

    ```sh
    sudo yum -y install fydeproxy
    sudo systemctl enable fydeproxy
    ```

1. Configure environment using a service unit override

    - We need to set the temporary directory due to `tmpfiles.d` daemon incompatibility

    ```sh
    sudo mkdir -p /etc/systemd/system/fydeproxy.service.d

    sudo bash -c "cat > /etc/systemd/system/fydeproxy.service.d/10-environment.conf <<EOF
    [Service]
    Environment='FYDE_ENROLLMENT_TOKEN=<paste here your Fyde Access Proxy enrollment link>'
    Environment='FYDE_ENVOY_LISTENER_PORT=<replace with the corresponding Fyde Access Proxy port, as configured in Fyde Enterprise Console>'
    Environment='TMPDIR=/var/run/fydeproxy'
    EOF"

    sudo chmod 600 /etc/systemd/system/fydeproxy.service.d/10-environment.conf
    ```

    - For highly available instalations, access to a redis server is required for communication between Fyde Orchestrators

    ```sh
    sudo bash -c "cat >> /etc/systemd/system/fydeproxy.service.d/10-environment.conf <<EOF
    Environment='FYDE_REDIS_HOST=<specify redis host ip or dns>'
    Environment='FYDE_REDIS_PORT=<specify redis port, defaults for 6379 if not included>'
    EOF"
    ```

1. Reload and start Fyde Proxy Orchestrator daemon

    ```sh
    sudo systemctl --system daemon-reload
    sudo systemctl start fydeproxy
    ```

1. Configure the firewall (if enabled)

    ```sh
    sudo firewall-cmd --zone=public --add-port="<replace with the corresponding Fyde Access Proxy port, as configured in Fyde Enterprise Console>/tcp" --permanent
    sudo firewall-cmd --reload
    ```

## Troubleshoot

- For troubleshooting steps please visit: [Troubleshooting]({{ site.baseurl }}{% link fyde-access-proxy/troubleshoot/README.md %})
