# Radxa BSP Builder Container

Debian-based container for building Radxa Board Support Package (BSP), supporting U-Boot and Linux kernel compilation for Radxa single-board computers.

## Usage

### Pull Container
```bash
podman pull ghcr.io/godspoon/radxa_bsp:latest
```

### Run Interactive Shell
```bash
podman run -it --rm ghcr.io/godspoon/radxa_bsp:latest /bin/bash
```

### Build U-Boot for Radxa Zero
```bash
podman run -it --rm ghcr.io/godspoon/radxa_bsp:latest /build/bsp/bsp u-boot latest radxa-zero
```

### Mount Local Directory (Optional)
```bash
podman run -it --rm -v /path/to/local/dir:/build/output ghcr.io/godspoon/radxa_bsp:latest /bin/bash
```

## Build Container Locally
```bash
git clone https://github.com/GodSpoon/radxa_bsp.git
cd radxa_bsp
podman build -t ghcr.io/godspoon/radxa_bsp:latest .
```

## Push New Build
```bash
podman push ghcr.io/godspoon/radxa_bsp:latest
```

## Notes
- Container includes pre-cloned BSP repository
- ARM64 cross-compilation toolchain pre-installed
- Build artifacts created in container unless mounted volume specified
