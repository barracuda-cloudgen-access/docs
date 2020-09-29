#!/usr/bin/env bash
#
# Copyright (c) 2019-present, Fyde, Inc.
# All rights reserved.
#

# Set error handling

set -euo pipefail

# Set help

function program_help {

    echo -e "Configure awslogs package

Available parameters:
  -h \\t\\t- Show this help
  -l \\t\\t- Specify Log Stream Name
  -r \\t\\t- Specify Log Region
"
    exit 0

}

# Get parameters

while getopts ":hl:r:" OPTION 2>/dev/null; do
    case "${OPTION}" in
        h)
            program_help
        ;;
        l)
            LOG_STREAM_NAME="${OPTARG}"
        ;;
        r)
            LOG_REGION="${OPTARG}"
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

# Run

if [[ -z "${LOG_STREAM_NAME}" ]]; then
    log_entry "ERROR" "Requires Log Stream Name (-h for more info)"
    exit 1
fi

if [[ -z "${LOG_REGION}" ]]; then
    log_entry "ERROR" "Requires Log Region (-h for more info)"
    exit 1
fi

log_entry "INFO" "Install awslogs"
yum install -y awslogs

log_entry "INFO" "Configure awslogs"

cat > /etc/awslogs/awscli.conf <<EOF
[plugins]
cwlogs = cwlogs
[default]
region = ${LOG_REGION}
EOF
chmod 600 /etc/awslogs/awscli.conf

cat > /etc/awslogs/awslogs.conf <<EOF
[general]
state_file = /var/lib/awslogs/agent-state

[/var/log/messages]
file = /var/log/messages
log_group_name = ${LOG_STREAM_NAME}
log_stream_name = {instance_id}
datetime_format = %Y-%m-%dT%H:%M:%S%z
initial_position = start_of_file
time_zone = UTC
EOF
chmod 600 /etc/awslogs/awslogs.conf

log_entry "INFO" "Enable and start service"
systemctl enable awslogsd.service
systemctl restart awslogsd.service
