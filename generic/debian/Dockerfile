# ----------------------------------
# Cubex Hosting Custom Image for PocketMine-MP
# Base Image: ghcr.io/cubexhosting/images:generic-debian
# ----------------------------------

    FROM debian:bookworm-slim

    LABEL author="Cubex Hosting" maintainer="admin@cubex.cc"
    
    ENV DEBIAN_FRONTEND=noninteractive
    
    # Add container user
    RUN useradd -m -d /home/container -s /bin/bash container
    
    # Install essential packages, removing unnecessary ones
    RUN apt-get update && apt-get upgrade -y \
        && apt-get install -y --no-install-recommends \
            libssl1.1 libsqlite3-0 tzdata \
            wget curl tar jq ca-certificates \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
        && rm -rf /usr/share/doc /usr/share/man /usr/share/info
    
    # Set locale
    RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
        && locale-gen \
        && update-locale LANG=en_US.UTF-8
    
    # Set environment variables
    ENV USER=container HOME=/home/container
    
    # Set working directory
    WORKDIR /home/container
    
    # Copy entrypoint script
    COPY ./entrypoint.sh /entrypoint.sh
    
    # Set entrypoint
    CMD ["/bin/bash", "/entrypoint.sh"]
    