#!/bin/bash
set -e

cd /home/container

# Fix permissions for install scripts if they exist
if [ -d "/mnt/install" ]; then
    find /mnt/install -name "*.sh" -type f ! -executable -exec chmod +x {} \; 2>/dev/null || true
fi

# Make internal Docker IP address available to processes
export INTERNAL_IP=$(ip route get 1 2>/dev/null | awk '{print $(NF-2); exit}' || echo "127.0.0.1")

# Replace Startup variables with proper escaping
MODIFIED_STARTUP=$(printf '%s\n' "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
printf "customer@cubex:~# %s\n" "${MODIFIED_STARTUP}"

# Run the Server
exec bash -c "${MODIFIED_STARTUP}"