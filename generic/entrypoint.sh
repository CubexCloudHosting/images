#!/bin/bash
set -e

# Fix permissions for install and server directories if they exist
if [ -d "/mnt/install" ]; then
    # Make all shell scripts executable
    find /mnt/install -name "*.sh" -type f -exec chmod +x {} \; 2>/dev/null || true
    # Ensure we can write to the directory
    chmod -R 755 /mnt/install 2>/dev/null || true
fi

if [ -d "/mnt/server" ]; then
    chmod -R 755 /mnt/server 2>/dev/null || true
fi

cd /home/container

# Make internal Docker IP address available to processes
export INTERNAL_IP=$(ip route get 1 2>/dev/null | awk '{print $(NF-2); exit}' || echo "127.0.0.1")

# Replace Startup variables with proper escaping
MODIFIED_STARTUP=$(printf '%s\n' "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
printf "customer@cubex:~# %s\n" "${MODIFIED_STARTUP}"

# Run the Server
exec bash -c "${MODIFIED_STARTUP}"