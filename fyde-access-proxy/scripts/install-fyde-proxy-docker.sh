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
DL_MANIFEST_BASE="https://raw.githubusercontent.com/fyde/docs/master/fyde-access-proxy/docker/docker-compose.yml"
DL_MANIFEST_TEST="https://raw.githubusercontent.com/fyde/docs/master/fyde-access-proxy/docker/docker-compose-httptest.yml"

# Request information

log_entry "INFO" "Please provide required variables"

read -r -p "Specify Fyde Access Proxy public port (8000): " PUBLIC_PORT
PUBLIC_PORT=${PUBLIC_PORT:-"8000"}

read -r -p "Install test resource (N/y): " INSTALL_TEST

read -r -p "Paste the Fyde Access Proxy enrollment link [hidden]: " -s PROXY_TOKEN
echo ""

# Get docker install script and execute

log_entry "INFO" "Install docker"

if ! docker version &> /dev/null
then
    curl -fsSL "$DL_DOCKER" -o get-docker.sh
    sh get-docker.sh
else
    log_entry "WARNING" "Docker detected, skipping install"
fi

log_entry "INFO" "Enable docker service on boot"

systemctl enable docker

log_entry "INFO" "Starting docker"

systemctl start docker

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

log_entry "INFO" "Downloading docker-compose manifest(s)"
if [[ "${INSTALL_TEST,,}" =~ ^(y|yes)$ ]]
then
    log_entry "INFO" "Including test resource"
    COMPOSE_FILES=(-f docker-compose.yml -f docker-compose-httptest.yml)
    curl -fsSL "$DL_MANIFEST_BASE" -o docker-compose.yml
    curl -fsSL "$DL_MANIFEST_TEST" -o docker-compose-httptest.yml
else
    log_entry "INFO" "Skipping test resource"
    COMPOSE_FILES=(-f docker-compose.yml)
    curl -fsSL "$DL_MANIFEST_BASE" -o docker-compose.yml
fi

log_entry "INFO" "Replacing variables"
sed -i -E "s|8000:8000|${PUBLIC_PORT}:8000|" docker-compose.yml
sed -i -E "s|(<paste\ here\ your\ Fyde\ Access\ Proxy\ enrollment\ link>)|${PROXY_TOKEN/\&/\\&}|g" docker-compose.yml

# Start containers

log_entry "INFO" "Starting containers"
docker-compose "${COMPOSE_FILES[@]}" up -d

log_entry "WARNING" "Manifest(s) saved in this folder"
log_entry "INFO" "To check container logs please run:"
echo "sudo docker-compose ${COMPOSE_FILES[*]} logs -f"

log_entry "INFO" "Complete."
