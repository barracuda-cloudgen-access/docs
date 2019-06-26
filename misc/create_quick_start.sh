#!/usr/bin/env bash
#
# Copyright (c) 2019-present, Fyde, Inc.
# All rights reserved.
#

# Project's root path
GIT_ROOT=$(git rev-parse --show-toplevel 2> /dev/null)

QS_FILE="${GIT_ROOT}/quick_start.md"

read -r -d '' QS_START <<'EOF'
# Quick Start

Follow these steps to perform the required configuration to access a resource protected by a Fyde Proxy.
EOF

read -r -d '' QS_END <<'EOF'
\n\n## Access created resource

- Enroll a new device for the created user by acessing the enrollment link
  - The link is sent to the email configured for the user or by sharing the link from the user details

- Access the configured resource
EOF

QS_INCLUDE=( \
"${GIT_ROOT}/console/configurations/add_proxy.md" \
"${GIT_ROOT}/proxy/fyde_proxy_docker.md" \
"${GIT_ROOT}/console/configurations/add_resource.md" \
"${GIT_ROOT}/console/configurations/add_user.md" \
)

QS_CONTENT=""

echo "Output -> ${QS_FILE}"

for x in "${QS_INCLUDE[@]}"
do
    echo "Processing -> $x"
    REL_PATH="$(git ls-files --full-name "$x")"
    QS_CONTENT+="\n\n$(sed -E 's|^#|##|' "$x" | sed -E "s|\!\[(.*)\]\((.*)\)|\!\[\1\](${REL_PATH%/*}/\2)|g")"
done

echo -e "${QS_START}${QS_CONTENT}${QS_END}" > "$QS_FILE"

echo "Done."
