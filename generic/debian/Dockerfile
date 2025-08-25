# ----------------------------------
# Cubex Cloud Hosting Custom Image for PocketMine-MP
# Base Image: ghcr.io/cubexcloudhosting/images:generic-debian
# ----------------------------------

FROM debian:bookworm-slim

LABEL author="Cubex Cloud Hosting" maintainer="admin@cubex.cc"

ENV DEBIAN_FRONTEND=noninteractive \
    USER=container \
    HOME=/home/container \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Single layer for all system setup to minimize image size
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        unzip \
        git \
        iproute2 \
        locales \
        tzdata \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 \
    && useradd -m -d /home/container -s /bin/bash container \
    && mkdir -p /mnt/install \
    && chown -R container:container /mnt/install \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

WORKDIR /home/container

# Copy and set permissions for entrypoint in single layer
COPY --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER container

CMD ["/bin/bash", "/entrypoint.sh"]
