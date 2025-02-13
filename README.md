# Radxa BSP Builder Container

This container provides a build environment for the Radxa Board Support Package (BSP), focusing on U-Boot and Linux kernel compilation for Radxa single-board computers.

## Technical Overview

- Base Image: Debian Bullseye
- Architecture Support: ARM64 cross-compilation
- Key Components:
  - Cross-compilation toolchain
  - U-Boot build dependencies
  - Linux kernel build dependencies
  - Python 2 & 3 environments
  - FPM for package building

## Container Registry

The container is available on GitHub Container Registry (GHCR):
```
ghcr.io/godspoon/radxa_bsp:latest
```

## Usage

### Pull the Container
```bash
podman pull ghcr.io/godspoon/radxa_bsp:latest
```

### Run Interactive Shell
```bash
podman run -it --rm -v "$(pwd)":/build ghcr.io/godspoon/radxa_bsp:latest
```

### Build U-Boot for Radxa Zero
```bash
podman run -it --rm -v "$(pwd)":/build ghcr.io/godspoon/radxa_bsp:latest ./bsp u-boot latest radxa-zero
```

### Build with Local BSP Directory
```bash
podman run -it --rm -v "$(pwd)":/build ghcr.io/godspoon/radxa_bsp:latest
```

### Override Entrypoint (for debugging)
```bash
podman run -it --rm --entrypoint /bin/bash ghcr.io/godspoon/radxa_bsp:latest
```

## Building Locally

To build the container locally:

```bash
git clone https://github.com/GodSpoon/radxa_bsp.git
cd radxa_bsp
podman build -t ghcr.io/godspoon/radxa_bsp:latest .
```

## Environment Variables

The container respects the following environment variables:
- `CROSS_COMPILE`: Set to `aarch64-linux-gnu-` by default
- `ARCH`: Set to `arm64` for kernel builds

## Notes

- The container automatically clones the BSP repository if not mounted
- All build artifacts are created in the mounted `/build` directory
- The container runs with the default entrypoint that handles BSP repository setup
