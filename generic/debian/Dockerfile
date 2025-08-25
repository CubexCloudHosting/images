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
        jq \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 \
    && useradd -m -d /home/container -s /bin/bash container \
    && mkdir -p /mnt/install /mnt/server \
    && chmod 755 /mnt/install /mnt/server \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER container

RUN echo '  if [ -d "/mnt/install" ]; then' >> /usr/local/bin/fix-perms-and-run.sh \
    && echo '    find /mnt/install -name "*.sh" -type f -exec chmod +x {} \; 2>/dev/null || true' >> /usr/local/bin/fix-perms-and-run.sh \
    && echo '  fi' >> /usr/local/bin/fix-perms-and-run.sh \
    && echo '  exec gosu container /entrypoint.sh "$@"' >> /usr/local/bin/fix-perms-and-run.sh \
    && echo 'else' >> /usr/local/bin/fix-perms-and-run.sh \
    && echo '  exec /entrypoint.sh "$@"' >> /usr/local/bin/fix-perms-and-run.sh \
    && echo 'fi' >> /usr/local/bin/fix-perms-and-run.sh \
    && chmod +x /usr/local/bin/fix-perms-and-run.sh

CMD ["/usr/local/bin/fix-perms-and-run.sh"]
