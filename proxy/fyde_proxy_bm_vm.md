# Install Fyde Proxy in Bare Metal / Virtual Machine

- Supported distributions:

  - [CentOS 7](##centos-7)

## Centos 7

1. Install Software Collections (SCL) repository

    ```sh
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    yum -y install centos-release-scl yum-utils
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo
    ```

1. Add Fyde repository

    ```sh
    yum-config-manager -y --add-repo https://downloads.fyde.com/stable.repo
    ```

1. Install Envoy Proxy

    - Logs go to `/var/log/envoy/envoy.log`

    ```sh
    yum -y install envoy
    systemctl enable envoy
    systemctl start envoy
    ```

1. Install Fyde-Proxy orchestrator and authz system

    - Logs go to journal (`journalctl -u fydeproxy`)

    ```sh
    yum -y install fydeproxy
    systemctl enable fydeproxy
    ```

1. Deploy enrollment token using a service unit override

    - NOTE: [Proxy Enrollment Link](../console/configurations/add_proxy.md#adding-a-proxy)

    ```sh
    mkdir -p /etc/systemd/system/fydeproxy.service.d

    cat > /etc/systemd/system/fydeproxy.service.d/10-enrollment.conf <<EOF
    [Service]
    Environment='FYDE_ENROLLMENT_TOKEN=<paste here your proxy enrollment link>'
    EOF

    chmod 600 /etc/systemd/system/fydeproxy.service.d/10-enrollment.conf

    systemctl --system daemon-reload
    systemctl start fydeproxy
    ```

- Make sure the Access Proxy port, as configured in the management console, is allowed in the firewall
