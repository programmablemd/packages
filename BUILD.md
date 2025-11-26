# Building Spry SQLPage Packages

This document describes how to build spry-sqlpage packages for various operating systems using DALEC.

## Prerequisites

### Required Tools

- **Docker** (version 20.10 or later)
- **Docker Buildx** (usually included with Docker Desktop)
- **Make** (optional, for convenience commands)

### Verify Prerequisites

```bash
# Check Docker version
docker --version

# Check Buildx is available
docker buildx version

# Ensure BuildKit is enabled
export DOCKER_BUILDKIT=1
```

## Quick Start

### Build All Packages

```bash
make build-all
```

This will build packages for:
- Ubuntu 22.04 (Jammy) - DEB
- Debian 12 (Bookworm) - DEB
- Rocky Linux 9 - RPM
- Alma Linux 9 - RPM
- Windows - ZIP (cross-compiled)

### Build Specific Platform

```bash
# Ubuntu Jammy
make build-jammy

# Debian Bookworm
make build-bookworm

# Rocky Linux 9
make build-rocky

# Alma Linux 9
make build-alma

# Windows
make build-windows
```

## Manual Build Commands

If you prefer not to use Make, you can run Docker commands directly:

### DEB Packages

```bash
# Ubuntu Jammy
docker buildx build \
  --target jammy \
  --output type=local,dest=./output/jammy \
  -f dalec-spry-sqlpage.yaml \
  .

# Debian Bookworm
docker buildx build \
  --target bookworm \
  --output type=local,dest=./output/bookworm \
  -f dalec-spry-sqlpage.yaml \
  .
```

### RPM Packages

```bash
# Rocky Linux 9
docker buildx build \
  --target rockylinux9 \
  --output type=local,dest=./output/rockylinux9 \
  -f dalec-spry-sqlpage.yaml \
  .

# Alma Linux 9
docker buildx build \
  --target almalinux9 \
  --output type=local,dest=./output/almalinux9 \
  -f dalec-spry-sqlpage.yaml \
  .
```

### Windows Package

```bash
docker buildx build \
  --target windowscross \
  --output type=local,dest=./output/windows \
  -f dalec-spry-sqlpage.yaml \
  .
```

## Using Docker Compose

You can also use Docker Compose to build packages:

```bash
# Build for specific platform
docker-compose run build-jammy
docker-compose run build-bookworm
docker-compose run build-rocky
docker-compose run build-alma
docker-compose run build-windows
```

## Local Compilation with Deno

For development and testing, you can compile directly with Deno:

```bash
# Install Deno (if not already installed)
curl -fsSL https://deno.land/install.sh | sh

# Compile spry-sqlpage
make compile-local

# Or manually:
deno compile \
  --allow-all \
  --import-map=import_map.json \
  --output=spry-sqlpage \
  spry_sqlpage.ts
```

## Output Location

Built packages will be in the `output/` directory:

```
output/
├── jammy/
│   └── spry-sqlpage_0.1.0-1_amd64.deb
├── bookworm/
│   └── spry-sqlpage_0.1.0-1_amd64.deb
├── rockylinux9/
│   └── spry-sqlpage-0.1.0-1.x86_64.rpm
├── almalinux9/
│   └── spry-sqlpage-0.1.0-1.x86_64.rpm
└── windows/
    └── spry-sqlpage-windows.zip
```

## Troubleshooting

### BuildKit Not Enabled

If you see errors about BuildKit, ensure it's enabled:

```bash
export DOCKER_BUILDKIT=1
```

Or add to your Docker daemon configuration (`/etc/docker/daemon.json`):

```json
{
  "features": {
    "buildkit": true
  }
}
```

### Permission Denied

If you encounter permission issues with Docker:

```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Log out and back in for changes to take effect
```

### Clean Build

To start fresh:

```bash
make clean
```

## CI/CD

The GitHub Actions workflow (`.github/workflows/build.yml`) automatically builds packages for all platforms on:
- Push to main branch
- New tags (v*)
- Pull requests

## More Information

- [DALEC Documentation](https://project-dalec.github.io/dalec/)
- [Spry Project](https://github.com/programmablemd/spry)
- [Deno Documentation](https://deno.land/)

