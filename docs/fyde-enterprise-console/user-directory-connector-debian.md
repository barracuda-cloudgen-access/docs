---
layout: default
title: Install in Debian/Ubuntu
parent: User Directory Connector
grand_parent: Fyde Enterprise Console
nav_order: 1
---
# Install in Debian/Ubuntu

- Minimum OS supported versions:
  - Any modern systemd debian-based OS

- Requires a valid User Directory connector token

## Steps

1. Add Fyde repository

    ```sh

REPO_URL="downloads.fyde.com"
wget -q -O - "https://$REPO_URL/fyde-public-key.asc" | sudo apt-key add -
sudo bash -c "cat > /etc/apt/sources.list.d/fyde.list <<EOF
deb https://$REPO_URL/apt stable main
EOF"
sudo apt update
    ```

2. Install Fyde User Directory Connector

    ```sh
    sudo apt install fyde-connector
    sudo systemctl enable fyde-connector
    ```

3. Configure environment using a service unit override (example with Okta)

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

4. Reload and start Fyde User Directory Connector

    ```sh
    sudo systemctl --system daemon-reload
    sudo systemctl start fyde-connector
    ```

## Troubleshoot

- Check Fyde Access Proxy logs

  ```sh
  sudo journalctl -u fyde-connector -f
  ```
