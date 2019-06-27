# Install Fyde Proxy in Bare Metal / Virtual Machine

- Supported distributions:
  - CentOS 7

- Instalation requires a valid [Proxy Enrollment Link](../console/configurations/add_proxy.md#adding-a-proxy)

- Choose [**Install script**](##install-script) or [**Manual steps**](##manual-steps) to proceed

## Install script

- Please note that the steps below will execute scripts obtained externally
- We advise to inspect the content before execution

1. Download and execute script

    ```sh
    curl -fsSL https://url.fyde.me/install-fyde-proxy-centos | sudo bash
    ```

## Manual steps

1. Install Software Collections (SCL) repository

    ```sh
    sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    sudo yum -y install centos-release-scl yum-utils
    sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo
    ```

1. Add Fyde repository

    ```sh
    sudo yum-config-manager -y --add-repo https://downloads.fyde.com/stable.repo
    ```

1. Install Envoy Proxy

    ```sh
    sudo yum -y install envoy
    sudo systemctl enable envoy
    sudo systemctl start envoy
    ```

1. Install Fyde-Proxy orchestrator and authz system

    ```sh
    sudo yum -y install fydeproxy
    sudo systemctl enable fydeproxy
    ```

1. Configure environment using a service unit override

    - NOTE: [Proxy Enrollment Link](../console/configurations/add_proxy.md#adding-a-proxy)

    ```sh
    sudo mkdir -p /etc/systemd/system/fydeproxy.service.d

    sudo bash -c "cat > /etc/systemd/system/fydeproxy.service.d/10-environment.conf <<EOF
    [Service]
    Environment='FYDE_ENROLLMENT_TOKEN=<paste here your Proxy Enrollment Link>'
    Environment='FYDE_ENVOY_LISTENER_PORT=<Access Proxy port, as configured in the management console>'
    EOF"

    sudo chmod 600 /etc/systemd/system/fydeproxy.service.d/10-environment.conf
    ```

1. Reload and start Fyde-Proxy orchestrator daemon

    ```sh
    sudo systemctl --system daemon-reload
    sudo systemctl start fydeproxy
    ```

1. Configure the firewall (enabled by default in CentOS)

    ```sh
    sudo firewall-cmd --zone=public --add-port="<Access Proxy port, as configured in the management console>/tcp" --permanent
    sudo firewall-cmd --reload
    ```
