# ----------------------------------
# Cubex Hosting Custom Image for PocketMine-MP
# Base Image: ghcr.io/cubexhosting/images:generic-debian
# ----------------------------------

    FROM debian:bookworm-slim

    LABEL author="Cubex Hosting" maintainer="admin@cubex.cc"
    
    ENV DEBIAN_FRONTEND=noninteractive
    
    # Add the container user and set environment variables
    RUN useradd -m -d /home/container -s /bin/bash container \
        && ln -s /home/container /nonexistent \
        && apt update && apt upgrade -y \
        && apt install -y --no-install-recommends \
            gcc g++ libgcc1 libssl-dev sqlite3 locales tzdata \
            wget curl tar zip unzip git jq ca-certificates \
        # Set the locale and clean up apt cache to reduce image size
        && update-locale LANG=en_US.UTF-8 \
        && apt clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
    # Set environment variables
    ENV USER=container HOME=/home/container
    
    # Set working directory
    WORKDIR /home/container
    
    # Copy entrypoint script
    COPY ./entrypoint.sh /entrypoint.sh
    
    # Set entrypoint
    CMD ["/bin/bash", "/entrypoint.sh"]
    