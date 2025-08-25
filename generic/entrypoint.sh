#!/bin/bash
set -e

cd /home/container

# Make internal Docker IP address available to processes
export INTERNAL_IP=$(ip route get 1 2>/dev/null | awk '{print $(NF-2); exit}' || echo "127.0.0.1")

# Replace Startup variables with proper escaping
MODIFIED_STARTUP=$(printf '%s\n' "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
printf "customer@cubex:~# %s\n" "${MODIFIED_STARTUP}"

# Run the Server
exec bash -c "${MODIFIED_STARTUP}"