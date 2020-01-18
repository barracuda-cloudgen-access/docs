#!/usr/bin/env bash
#
# Copyright (c) 2019-present, Fyde, Inc.
# All rights reserved.
#

# Set error handling

set -euo pipefail

# Functions

function log_entry() {

    local LOG_TYPE="${1:?Needs log type}"
    local LOG_MSG="${2:?Needs log message}"
    local COLOR='\033[93m'
    local ENDCOLOR='\033[0m'

    echo -e "${COLOR}$(date "+%Y-%m-%d %H:%M:%S") [$LOG_TYPE] ${LOG_MSG}${ENDCOLOR}"

}

# Request information

log_entry "INFO" "Please provide required variables"

read -r -p "Specify Fyde Access Proxy public port (443): " PUBLIC_PORT
PUBLIC_PORT=${PUBLIC_PORT:-"443"}

while [[ -z "${PROXY_TOKEN:-}" ]];
do
    read -r -p "Paste the Fyde Access Proxy enrollment link (hidden): " -s PROXY_TOKEN
    echo ""
    if [[ -z "${PROXY_TOKEN:-}" ]]
    then
        log_entry "ERROR" "Fyde Access Proxy enrollment link cannot be empty"
    fi
done

# Run

log_entry "INFO" "Install pre-requisites"

yum -y install yum-utils

log_entry "INFO" "Add Fyde repository"

yum-config-manager -y --add-repo https://downloads.fyde.com/fyde.repo

log_entry "INFO" "Install Envoy Proxy"

yum -y install envoy
systemctl enable envoy

if [ "$PUBLIC_PORT" -lt 1024 ];
then
    log_entry "INFO" "Add CAP_NET_BIND_SERVICE to Envoy using a service unit override"

    mkdir -p /etc/systemd/system/envoy.service.d
    cat > /etc/systemd/system/envoy.service.d/10-add-cap-net-bind.conf <<EOF
[Service]
Capabilities=CAP_NET_BIND_SERVICE+ep
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_BIND_SERVICE
SecureBits=keep-caps
EOF
    chmod 600 /etc/systemd/system/envoy.service.d/10-add-cap-net-bind.conf
fi

log_entry "INFO" "Reload and start Envoy Proxy"

systemctl --system daemon-reload
systemctl start envoy

log_entry "INFO" "Install Fyde Proxy Orchestrator and authz system"

yum -y install fydeproxy
systemctl enable fydeproxy

log_entry "INFO" "Configure environment using a service unit override"

mkdir -p /etc/systemd/system/fydeproxy.service.d
cat > /etc/systemd/system/fydeproxy.service.d/10-environment.conf <<EOF
[Service]
Environment='FYDE_ENROLLMENT_TOKEN=${PROXY_TOKEN}'
Environment='FYDE_ENVOY_LISTENER_PORT=${PUBLIC_PORT}'
EOF
chmod 600 /etc/systemd/system/fydeproxy.service.d/10-environment.conf

log_entry "INFO" "Reload and start Fyde Proxy Orchestrator daemon"

systemctl --system daemon-reload
systemctl start fydeproxy

log_entry "INFO" "Configure the firewall"

if systemctl status firewalld &> /dev/null
then
    firewall-cmd --zone=public --add-port="${PUBLIC_PORT}/tcp" --permanent
    firewall-cmd --reload
else
    log_entry "WARNING" "Firewalld not started, skipping configuration"
fi

log_entry "INFO" "To check Envoy Proxy logs please run:"
echo "sudo tail /var/log/envoy/envoy.log -f"

log_entry "INFO" "To check Fyde Proxy Orchestrator logs please run:"
echo "sudo journalctl -u fydeproxy -f"

log_entry "INFO" "Complete."
