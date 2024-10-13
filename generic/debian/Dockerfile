# ----------------------------------
# Cubex Hosting Custom Image for PocketMine-MP
# Base Image: ghcr.io/cubexhosting/images:generic-debian
# ----------------------------------

    FROM debian:bookworm-slim

    LABEL author="Cubex Hosting" maintainer="admin@cubex.cc"
    
    ENV DEBIAN_FRONTEND=noninteractive
    
    # Step 1: Add the container user
    RUN useradd -m -d /home/container -s /bin/bash container
    
    # Step 2: Run apt-get update and install essential packages
    RUN apt-get update && apt-get upgrade -y \
        && apt-get install -y --no-install-recommends \
            gcc g++ libgcc1 libssl-dev sqlite3 locales tzdata \
            wget curl tar zip unzip git jq ca-certificates
    
    # Step 3: Generate the required locale and configure it
    RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
        && locale-gen \
        && update-locale LANG=en_US.UTF-8
    
    # Step 4: Clean up apt cache and temporary files
    RUN apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
    # Set environment variables
    ENV USER=container HOME=/home/container
    
    # Set working directory
    WORKDIR /home/container
    
    # Copy entrypoint script
    COPY ./entrypoint.sh /entrypoint.sh
    
    # Set entrypoint
    CMD ["/bin/bash", "/entrypoint.sh"]
    