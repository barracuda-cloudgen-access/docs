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

# Set download links

DL_DOCKER="https://get.docker.com"
DL_COMPOSE="https://github.com/docker/compose/releases/download/1.24.0/docker-compose-"
DL_MANIFEST="https://raw.githubusercontent.com/fydeinc/docs/master/proxy/docker/docker-compose.yml"

# Request information

log_entry "INFO" "Please provide required variables"

read -r -p "Specify proxy public port (8000): " PUBLIC_PORT
PUBLIC_PORT=${PUBLIC_PORT:-"8000"}
read -r -p "Paste the Proxy Enrollment Link (hidden): " -s PROXY_TOKEN
echo ""

# Get docker install script and execute

log_entry "INFO" "Install docker"

if ! docker version &> /dev/null
then
    curl -fsSL "$DL_DOCKER" -o get-docker.sh
    sh get-docker.sh
    systemctl start docker
else
    log_entry "WARNING" "Docker detected, skipping install"
fi

# Instal docker-compose

log_entry "INFO" "Installing docker-compose"

if ! docker-compose version &> /dev/null
then
    curl -fsSL "${DL_COMPOSE}$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    if ! docker-compose version &> /dev/null
    then
        ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    fi
else
    log_entry "WARNING" "Docker-compose detected, skipping install"
fi

# Get docker-compose manifest and replace values

log_entry "INFO" "Downloading docker-compose manifest"
curl -fsSL "$DL_MANIFEST" -o docker-compose.yml

log_entry "INFO" "Replacing variables"
sed -i -E "s|8000:8000|${PUBLIC_PORT}:8000|" docker-compose.yml
sed -i -E "s|(<paste\ here\ your\ Proxy\ Enrollment\ Link>)|${PROXY_TOKEN/\&/\\&}|g" docker-compose.yml

# Start containers

log_entry "INFO" "Starting docker-compose"
docker-compose -f docker-compose.yml up -d

log_entry "WARNING" "Manifest saved in this folder"
log_entry "INFO" "To check container logs please run:"
echo "sudo docker-compose -f docker-compose.yml logs -f"

log_entry "INFO" "Complete."
