---
layout: default
title: Install in CentOS
parent: User Directory Connector
grand_parent: Fyde Enterprise Console
nav_order: 1
---
# Install in CentOS

- Supported distributions:
  - CentOS 7

- Requires a valid User Directory connector token

## Steps

1. Install yum repository manager and update cURL (necessary in old CentOS 7.0 versions)

    ```sh
    sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    sudo yum -y install yum-utils curl
    ```

1. Add Fyde repository

    ```sh
    sudo yum-config-manager -y --add-repo https://downloads.fyde.com/fyde.repo
    ```

1. Install Fyde User Directory Connector

    ```sh
    sudo yum -y install fyde-connector
    sudo systemctl enable fyde-connector
    ```

1. Configure environment using a service unit override (example with Okta)

    - Check all the available [parameters]({{ site.baseurl }}{% link fyde-enterprise-console/user-directory-connector-parameters.md %})

    ```sh
    sudo mkdir -p /etc/systemd/system/fyde-connector.service.d

    sudo bash -c "cat > /etc/systemd/system/fyde-connector.service.d/10-environment.conf <<EOF
    [Service]
    Environment='FYDE_ENROLLMENT_TOKEN=https://enterprise.fyde.com/connectors/v1/connectorid1?auth_token=connector1_token&tenant_id=tenantid1'
    Environment='FYDE_OKTA_AUTH_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    Environment='FYDE_OKTA_DOMAINNAME=xxxxxx.okta.com'
    EOF"

    sudo chmod 600 /etc/systemd/system/fyde-connector.service.d/10-environment.conf
    ```

1. Reload and start Fyde User Directory Connector

    ```sh
    sudo systemctl --system daemon-reload
    sudo systemctl start fyde-connector
    ```

## Troubleshoot

- Check Fyde Access Proxy logs

  ```sh
  sudo journalctl -u fyde-connector -f
  ```
