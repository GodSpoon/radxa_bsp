# syntax=docker/dockerfile:1

FROM debian:bullseye as base-arm64
RUN apt-get update && \
    apt-get full-upgrade --no-install-recommends -y \
        less jq \
        binfmt-support qemu-user-static \
        build-essential gcc-arm-none-eabi git ruby sudo apt-utils \
        python3 python2 python-is-python2 curl debhelper \
        python3-distutils python3-pkg-resources python3-setuptools python3-pyelftools python3-ply python3-git \
        cpio bc flex fakeroot bison rsync kmod swig device-tree-compiler u-boot-tools \
        python2-dev python3-dev libssl-dev uuid-dev libgnutls28-dev wget

RUN dpkg --add-architecture arm64 && \
    apt-get update && \
    apt-get full-upgrade --no-install-recommends -y \
        crossbuild-essential-arm64 libc6:arm64 libssl-dev:arm64

RUN gem install fpm && \
    curl https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2 && \
    python2 -m pip install pyelftools==0.29 && \
    adduser --gecos runner --disabled-password runner && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /build

# Add entrypoint script
COPY <<EOF /entrypoint.sh
#!/bin/bash
set -e

# Clone BSP repository if not mounted
if [ ! -d "/build/bsp" ]; then
    git clone --recurse-submodules https://github.com/radxa-repo/bsp.git
    cd bsp
else
    cd bsp
    # Update submodules if directory is mounted
    git submodule update --init --recursive
fi

# Simple command handling
if [ $# -eq 0 ]; then
    /bin/bash
else
    sh -c "$*"
fi
EOF

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
