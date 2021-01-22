#!/usr/bin/env bash
#
# Copyright (c) 2020 Barracuda Networks, Inc. All rights reserved.
#

# Set error handling

set -euo pipefail

# Set help

function program_help {

    echo -e "Install CloudGen Access User Directory Connector script

Available parameters:
  -h \\t\\t- Show this help
  -l string \\t- Loglevel (debug, info, warning, error, critical), defaults to info.
  -n \\t\\t- Don't start services after install
  -t token \\t- Specify CloudGen Access Connector enrollment token
  -z \\t\\t- Skip configuring ntp server <optional>
  -e \\t\\t- Extra connector environment variables (can be used multiple times)
"
    exit 0

}

# Get parameters
EXTRA=()
while getopts ":e:hl:nt:z" OPTION 2>/dev/null; do
    case "${OPTION}" in
        e)
            VALUE="$(echo "${OPTARG}" | cut -d= -f1 | tr [:lower:]- [:upper:]_)"
            if ! [[ "${VALUE}" =~ ^FYDE_ ]]; then
                VALUE="FYDE_${VALUE}"
            fi
            EXTRA+=("${VALUE}=$(echo "${OPTARG}" | cut -d= -f2-)")
        ;;
        h)
            program_help
        ;;
        l)
            LOGLEVEL="${OPTARG}"
        ;;
        n)
            NO_START_SVC="true"
        ;;
        t)
            CONNECTOR_TOKEN="${OPTARG}"
            if ! [[ "${CONNECTOR_TOKEN:-}" =~ ^http[s]?://[^/]+/connectors/v[0-9]+/[0-9a-f]+\?auth_token=[^\&]+\&tenant_id=[0-9a-f-]+$ ]]; then
                echo "CloudGen Access Connector enrollment token is invalid, please try again"
                exit 3
            fi
        ;;
        z)
            SKIP_NTP="true"
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

if [[ -z "${CONNECTOR_TOKEN:-}" ]]; then
    log_entry "INFO" "Please provide required variables"

    while [[ -z "${CONNECTOR_TOKEN:-}" ]]; do
        read -r -p "Paste the CloudGen Access Connector enrollment token here (hidden): " -s CONNECTOR_TOKEN
        echo ""
        if [[ -z "${CONNECTOR_TOKEN:-}" ]]; then
            log_entry "ERROR" "CloudGen Access Connector enrollment token cannot be empty"
        elif ! [[ "${CONNECTOR_TOKEN:-}" =~ ^http[s]?://[^/]+/connectors/v[0-9]+/[0-9a-f]+\?auth_token=[^\&]+\&tenant_id=[0-9a-f-]+$ ]]; then
            log_entry "ERROR" "CloudGen Access Connector enrollment token is invalid, please try again"
            unset CONNECTOR_TOKEN
        fi
    done
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
yum -y install yum-utils

if [[ "${SKIP_NTP:-}" == "true" ]]; then
    log_entry "INFO" "Skipping NTP configuration"
else
    log_entry "INFO" "Ensure chrony daemon is enabled on system boot and started"
    yum -y install chrony
    systemctl enable chronyd
    systemctl start chronyd

    log_entry "INFO" "Ensure time synchronization is enabled"
    timedatectl set-ntp on
fi

log_entry "INFO" "Add Fyde repository"
yum-config-manager -y --add-repo https://downloads.fyde.com/fyde.repo

log_entry "INFO" "Install CloudGen Access Connector"
yum -y install fyde-connector
systemctl enable fyde-connector

log_entry "INFO" "Configure CloudGen Access Connector"

UNIT_OVERRIDE=("[Service]" "Environment='FYDE_LOGLEVEL=${LOGLEVEL:-"info"}'")
UNIT_OVERRIDE+=("Environment='FYDE_ENROLLMENT_TOKEN=${CONNECTOR_TOKEN}'")

if ! [[ "${EXTRA[@]}" == *"AUTH_TOKEN"* ]]; then
    TMPFILE="$(mktemp --tmpdir fyde-connector.XXXXXXX)"
    /usr/bin/fyde-connector --dry-run --run-once "--enrollment-token=${CONNECTOR_TOKEN}" | tee "$TMPFILE"

    if grep -q 'Your Azure Authentication token is:' "$TMPFILE"; then
        AZURE_AUTH_TOKEN=$(egrep -o 'Your Azure Authentication token is:.+' "$TMPFILE" | cut -d: -f2-)
        UNIT_OVERRIDE+=("Environment='FYDE_AZURE_AUTH_TOKEN=${AZURE_AUTH_TOKEN}'")
    elif grep -q 'Your Google Suite token is:' "$TMPFILE"; then
        GOOGLE_AUTH_TOKEN=$(egrep -o 'Your Google Suite token is:.+' "$TMPFILE" | cut -d: -f2-)
        UNIT_OVERRIDE+=("Environment='FYDE_GOOGLE_AUTH_TOKEN=${GOOGLE_AUTH_TOKEN}'")
    elif grep -iq 'okta-auth-token and okta-domainname variables are both mandatory' "$TMPFILE"; then
        log_entry "ERROR" "okta-auth-token and okta-domainname variables are both mandatory"
        rm -f "$TMPFILE"
        exit 2
    fi
    rm -f "$TMPFILE"
elif [[ "${EXTRA[@]}" == *"OKTA_AUTH_TOKEN"* ]] && ! [[ "${EXTRA[@]}" == *"OKTA_DOMAINNAME"* ]]; then
    log_entry "ERROR" "okta-auth-token and okta-domainname variables are both mandatory"
    exit 2
fi

mkdir -p /etc/systemd/system/fyde-connector.service.d
printf "%s\n" "${UNIT_OVERRIDE[@]}" > /etc/systemd/system/fyde-connector.service.d/10-environment.conf
if [[ -n "${EXTRA[@]}" ]]; then
    printf "Environment='%s'\n" "${EXTRA[@]}" >> /etc/systemd/system/fyde-connector.service.d/10-environment.conf
fi
chmod 600 /etc/systemd/system/fyde-connector.service.d/10-environment.conf

systemctl --system daemon-reload

if [[ "${NO_START_SVC:-}" == "true" ]]; then
    log_entry "INFO" "Skip CloudGen Access Connector start"
else
    log_entry "INFO" "Start CloudGen Access Connector daemon"
    systemctl start fyde-connector
fi

log_entry "INFO" "To check logs:"
echo "journalctl -u fyde-connector -f"

if [[ "${NO_START_SVC:-}" == true ]]; then
    log_entry "INFO" "To start service:"
    echo "systemctl start fyde-connector"
fi

log_entry "INFO" "Complete."
