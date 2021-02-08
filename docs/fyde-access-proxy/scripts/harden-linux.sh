#!/usr/bin/env bash
#
# Copyright (c) 2021-present, Barracuda Networks Inc.
# All rights reserved.
#

# Set error handling

set -euo pipefail

# Set help

function program_help {

    echo -e "Harden Linux script

Available parameters:
  -h \\t\\t- Show this help
  -u \\t\\t- Unattended install, skip requesting input <optional>
  -r \\t\\t- Allow login as root (Default: false)
"
    exit 0

}

# Get parameters

ALLOW_ROOT='no'
while getopts ":hru" OPTION 2>/dev/null; do
    case "${OPTION}" in
        h)
            program_help
        ;;
        u)
            UNATTENDED_INSTALL="true"
        ;;
        r)
            ALLOW_ROOT='yes'
        ;;
        \?)
            echo "Invalid option: -${OPTARG}"
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

# Check if run as root

if [[ "$EUID" != "0" ]]; then
    log_entry "ERROR" "This script needs to be run as root"
    exit 1
fi

# Prepare inputs

if [[ "${UNATTENDED_INSTALL:-}" != "true" ]] && [[ -t 0 ]]; then
    log_entry "INFO" "Please provide required variables"

    read -r -p "Do you want to allow SSH as root user? (no): " ALLOW_ROOT
    ALLOW_ROOT=${ALLOW_ROOT:-"no"}
fi

# Pre-requisites

source /etc/os-release

log_entry "INFO" "Check for package manager lock file"
for i in $(seq 1 300); do
    if [[ "${ID_LIKE:-}" == *"debian"* ]]; then
        if ! fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1; then
            break
        fi
    elif [[ "${ID_LIKE:-}" == *"rhel"* ]]; then
        if ! [ -f /var/run/yum.pid ]; then
            break
        fi
    else
        echo "Unrecognized distribution type: ${ID_LIKE}"
        exit 4
    fi
    echo "Lock found. Check ${i}/300"
    sleep 1
done

log_entry "INFO" "Install pre-requisites"
if [[ "${ID_LIKE:-}" == *"debian"* ]]; then
  apt install -y unattended-upgrades software-properties-common python3-pip
  apt-add-repository --yes --update ppa:ansible/ansible
  apt install -y ansible
else
  dnf install -y yum-utils epel-release
  dnf install -y open-vm-tools dnf-automatic ansible
fi

# Hardening
log_entry "INFO" "Run Ansible playbooks"
ANSIBLE_TMP="$(mktemp -d)"
ansible-galaxy install dev-sec.os-hardening dev-sec.ssh-hardening \
    -p "${ANSIBLE_TMP}"
tee "${ANSIBLE_TMP}"/playbook.yml <<EOF
---
- hosts: localhost
  roles:
    - dev-sec.ssh-hardening
    - dev-sec.os-hardening
  vars:
    ssh_permit_root_login: '${ALLOW_ROOT:-"no"}'
    ssh_server_password_login: true
    sshd_authenticationmethods: 'publickey password'
EOF

if [[ "${ID_LIKE:-}" == *"debian"* ]]; then
  tee "/etc/apt/apt.conf.d/20auto-upgrades" <<EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
EOF
  tee -a "/etc/apt/apt.conf.d/50unattended-upgrades" <<EOF
Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
EOF

  ansible-playbook -i "localhost," \
      --connection=local --become \
      -e 'ansible_python_interpreter=/usr/bin/python3' \
      "${ANSIBLE_TMP}"/playbook.yml
  rm -rf "${ANSIBLE_TMP}"
else
  # Configure dnf-automatic (old yum-cron)
  tee "/etc/dnf/automatic.conf" <<EOF
[commands]
update_cmd = security
update_messages = yes
download_updates = yes
apply_updates = yes
random_sleep = 360
[emitters]
system_name = None
emit_via = stdio
output_width = 80
[email]
email_from = root@localhost
[base]
debuglevel = -2
mdpolicy = group:main
exclude = kernel*
EOF
  systemctl enable --now dnf-automatic.timer

  ansible-playbook -i "localhost," \
      --connection=local --become \
      "${ANSIBLE_TMP}"/playbook.yml
  rm -rf "${ANSIBLE_TMP}"
fi

log_entry "INFO" "Please REBOOT your instance before continuing"
