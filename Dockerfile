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
        python2-dev python3-dev libssl-dev uuid-dev libgnutls28-dev

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

# Clone BSP repository
RUN git clone --recurse-submodules https://github.com/radxa-repo/bsp.git

WORKDIR /build/bsp
