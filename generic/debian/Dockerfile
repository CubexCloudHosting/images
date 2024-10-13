# ----------------------------------
# Cubex Hosting Custom Image for PocketMine-MP
# Base Image: ghcr.io/cubexhosting/images:generic-debian
# ----------------------------------

# Use Alpine as the base image
FROM alpine:latest

LABEL author="Cubex Hosting" maintainer="admin@cubex.cc"

# Set environment variables
ENV USER=container HOME=/home/container

# Add container user
RUN adduser -D -h /home/container -s /bin/bash container

# Install necessary packages
RUN apk update \
    && apk add --no-cache \
        bash \
        curl \
        wget \
        jq \
        tar \
        zip \
        unzip \
        ca-certificates \
        libssl3 \
        sqlite-dev \
        tzdata \
        libpng \
        libjpeg-turbo \
        zlib \
        gcc \
        g++ \
        make \
        autoconf \
        automake \
        cmake \
        pkgconf \
        re2c \
        bzip2 \
        libtool

# Set working directory
WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Set entrypoint
CMD ["/bin/bash", "/entrypoint.sh"]
