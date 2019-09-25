---
layout: default
title: Install in Bare Metal / Virtual Machine
parent: Fyde Access Proxy
nav_order: 1
---
# Install in Bare Metal / Virtual Machine

- Supported distributions:
  - CentOS 7

- Requires a valid [Fyde Access Proxy enrollment link]({{ site.baseurl }}{% link fyde-enterprise-console/add-fyde-access-proxy.md %}#adding-a-proxy)

- Choose [**Install script**](#install-script) or [**Manual steps**](#manual-steps) to proceed

## Install script

- Please note that the steps below will execute scripts obtained externally

- We advise to inspect the content before execution

1. Download and execute installation script

    ```sh
    sudo bash -c "$(curl -fsSL https://url.fyde.me/install-fyde-proxy-centos)"
    ```

## Manual steps

1. Install yum repository manager and update cURL (necessary in old CentOS 7.0 versions)

    ```sh
    sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    sudo yum -y install yum-utils curl
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

    ```sh
    sudo mkdir -p /etc/systemd/system/fydeproxy.service.d

    sudo bash -c "cat > /etc/systemd/system/fydeproxy.service.d/10-environment.conf <<EOF
    [Service]
    Environment='FYDE_ENROLLMENT_TOKEN=<paste here your Fyde Access Proxy enrollment link>'
    Environment='FYDE_ENVOY_LISTENER_PORT=<replace with the Fyde Access Proxy port, as configured in Fyde Enterprise Console>'
    EOF"

    sudo chmod 600 /etc/systemd/system/fydeproxy.service.d/10-environment.conf
    ```

1. Reload and start Fyde Proxy Orchestrator daemon

    ```sh
    sudo systemctl --system daemon-reload
    sudo systemctl start fydeproxy
    ```

1. Configure the firewall (enabled by default in CentOS)

    ```sh
    sudo firewall-cmd --zone=public --add-port="<Fyde Access Proxy port, as configured in Fyde Enterprise Console>/tcp" --permanent
    sudo firewall-cmd --reload
    ```

## Troubleshoot

- For troubleshooting steps please visit: [Troubleshooting]({{ site.baseurl }}{% link fyde-access-proxy/troubleshoot.md %})
