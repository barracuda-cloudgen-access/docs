#!/usr/bin/env bash
#
# Copyright (c) 2019-present, Fyde, Inc.
# All rights reserved.
#

# Set error handling

set -euo pipefail

# Set help

function program_help {

    echo -e "Install Fyde Access Proxy script

Available parameters:
  -h \\t\\t- Show this help
  -l string \\t- Loglevel (debug, info, warning, error, critical), defaults to info.
  -n \\t\\t- Don't start services after install
  -p int \\t- Specify public port (1-65535), required for unattended instalation
  -r string \\t- Specify Redis host to use for token cache <only required for HA architecture>
  -s int \\t- Specify Redis port <optional>
  -t token \\t- Specify Fyde Access Proxy token
  -u \\t\\t- Unattended install, skip requesting input <optional>

Example for unattended instalation with Fyde Access Proxy token:
  - Specify the Fyde Access Proxy token inside quotes

  ${0} -p 443 -t \"https://xxxxxxxxxxxx\" -u

Example for unattended instalation with Fyde Access Proxy token with Redis endpoint:
  - Specify the Fyde Access Proxy token inside quotes

  ${0} -p 443 -t \"https://xxxxxxxxxxxx\" -u -r localhost -s 6379

Example for unattended instalation, skipping services start, without Fyde Access Proxy token:
  - The token can also be obtained automatically via AWS SSM/Secrets Manager
  - More info: https://fyde.github.io/docs/fyde-access-proxy/parameters/#fyde-proxy-orchestrator

  ${0} -n -p 443 -u
"
    exit 0

}

# Get parameters

while getopts ":hl:np:r:s:t:u" OPTION 2>/dev/null; do
    case "${OPTION}" in
        h)
            program_help
        ;;
        l)
            LOGLEVEL="${OPTARG}"
        ;;
        n)
            NO_START_SVC="true"
        ;;
        p)
            PUBLIC_PORT="${OPTARG}"
        ;;
        r)
            REDIS_HOST="${OPTARG}"
        ;;
        s)
            REDIS_PORT="${OPTARG}"
        ;;
        t)
            PROXY_TOKEN="${OPTARG}"
        ;;
        u)
            UNATTENDED_INSTALL="true"
        ;;
        \?)
            echo "Invalid option: -${OPTARG}"
            exit 3
        ;;
        :)
            echo "Option -${OPTARG} requires an argument." >&2
            exit 3
        ;;
        *)
            echo "${OPTARG} is an unrecognized option"
            exit 3
        ;;
    esac
done

# Functions

function log_entry() {

    local LOG_TYPE="${1:?Needs log type}"
    local LOG_MSG="${2:?Needs log message}"
    local COLOR='\033[93m'
    local ENDCOLOR='\033[0m'

    echo -e "${COLOR}$(date "+%Y-%m-%d %H:%M:%S") [$LOG_TYPE] ${LOG_MSG}${ENDCOLOR}"

}

# Prepare inputs

if [[ "${UNATTENDED_INSTALL:-}" == "true" ]] || ! [[ -t 0 ]]; then
    if [[ -z "${PUBLIC_PORT:-}" ]]; then
        log_entry "ERROR" "Unattended install requires public port (-h for more info)"
        exit 1
    fi
else
    log_entry "INFO" "Please provide required variables"

    read -r -p "Specify Fyde Access Proxy public port (443): " PUBLIC_PORT
    PUBLIC_PORT=${PUBLIC_PORT:-"443"}

    while [[ -z "${PROXY_TOKEN:-}" ]]; do
        read -r -p "Paste the Fyde Access Proxy enrollment link (hidden): " -s PROXY_TOKEN
        echo ""
        if [[ -z "${PROXY_TOKEN:-}" ]]; then
            log_entry "ERROR" "Fyde Access Proxy enrollment link cannot be empty"
        fi
    done

    read -r -p "Specify Redis host (only required for HA architecture): " REDIS_HOST
    if [ -n "${REDIS_HOST:-}" ]; then
        read -r -p "Specify Redis port (6379): " REDIS_PORT
        REDIS_PORT=${REDIS_PORT:-"6379"}
    fi
fi

# Pre-requisites

log_entry "INFO" "Check for yum lock file"
for i in $(seq 1 300); do
    if ! [ -f /var/run/yum.pid ]; then
        break
    fi
    echo "Lock found. Check ${i}/300"
    sleep 1
done

log_entry "INFO" "Install pre-requisites"
yum -y install yum-utils chrony

log_entry "INFO" "Ensure chrony daemon is enabled on system boot and started"
systemctl enable chronyd
systemctl start chronyd

log_entry "INFO" "Ensure time synchronization is enabled"
timedatectl set-ntp on

log_entry "INFO" "Add Fyde repository"
yum-config-manager -y --add-repo https://downloads.fyde.com/fyde.repo

# Envoy Proxy

log_entry "INFO" "Install Envoy Proxy"
yum -y install envoy
systemctl enable envoy

if [ "${PUBLIC_PORT}" -lt 1024 ]; then
    log_entry "INFO" "Configure Envoy Proxy"
    mkdir -p /etc/systemd/system/envoy.service.d
    cat > /etc/systemd/system/envoy.service.d/10-add-cap-net-bind.conf <<EOF
[Service]
Capabilities=CAP_NET_BIND_SERVICE+ep
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_BIND_SERVICE
SecureBits=keep-caps
EOF
    chmod 600 /etc/systemd/system/envoy.service.d/10-add-cap-net-bind.conf

    systemctl --system daemon-reload
fi

if [[ "${NO_START_SVC:-}" == true ]]; then
    log_entry "INFO" "Skip Envoy Proxy daemon start"
else
    log_entry "INFO" "Start Envoy Proxy daemon"
    systemctl start envoy
fi

# Fyde Proxy Orchestrator

log_entry "INFO" "Install Fyde Proxy Orchestrator"
yum -y install fydeproxy
systemctl enable fydeproxy

log_entry "INFO" "Configure Fyde Proxy Orchestrator"

UNIT_OVERRIDE=("[Service]" "Environment='FYDE_ENVOY_LISTENER_PORT=${PUBLIC_PORT}'")
UNIT_OVERRIDE+=("Environment='FYDE_LOGLEVEL=${LOGLEVEL:-"info"}'")

# Update tmp dir to avoid tmpfiles.d removing our uncompressed PyInstaller bundle
UNIT_OVERRIDE+=("Environment='TMPDIR=/var/run/fydeproxy'")

if [[ -n "${PROXY_TOKEN:-}" ]]; then
    UNIT_OVERRIDE+=("Environment='FYDE_ENROLLMENT_TOKEN=${PROXY_TOKEN}'")
fi

if [[ -n "${REDIS_HOST:-}" ]]; then
    UNIT_OVERRIDE+=("Environment='FYDE_REDIS_HOST=${REDIS_HOST}'")
    if [[ -n "${REDIS_PORT:-}" ]]; then
        UNIT_OVERRIDE+=("Environment='FYDE_REDIS_PORT=${REDIS_PORT}'")
    fi
fi

mkdir -p /etc/systemd/system/fydeproxy.service.d
printf "%s\n" "${UNIT_OVERRIDE[@]}" > /etc/systemd/system/fydeproxy.service.d/10-environment.conf
chmod 600 /etc/systemd/system/fydeproxy.service.d/10-environment.conf

systemctl --system daemon-reload

if [[ "${NO_START_SVC:-}" == "true" ]]; then
    log_entry "INFO" "Skip Fyde Proxy Orchestrator start"
else
    log_entry "INFO" "Start Fyde Proxy Orchestrator daemon"
    systemctl start fydeproxy
fi

log_entry "INFO" "Configure the firewall"
if systemctl status firewalld &> /dev/null; then
    firewall-cmd --zone=public --add-port="${PUBLIC_PORT}/tcp" --permanent
    firewall-cmd --reload
else
    log_entry "WARNING" "Firewalld not started, skipping configuration"
fi

log_entry "INFO" "Check logs:"
echo "tail /var/log/envoy/envoy.log -f"
echo "journalctl -u fydeproxy -f"

if [[ "${NO_START_SVC:-}" == true ]]; then
    log_entry "INFO" "Start services:"
    echo "systemctl start envoy"
    echo "systemctl start fydeproxy"
fi

log_entry "INFO" "Complete."