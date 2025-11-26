# Quick Start Guide

Get started with Spry SQLPage DALEC packages in minutes!

## For Users

### Install from Pre-built Packages

#### Ubuntu/Debian

```bash
# Download the latest release
wget https://github.com/programmablemd/packages/releases/latest/download/spry-sqlpage_jammy.deb

# Install
sudo dpkg -i spry-sqlpage_jammy.deb

# Verify installation
spry-sqlpage --version
```

#### Rocky Linux/Alma Linux

```bash
# Download the latest release
wget https://github.com/programmablemd/packages/releases/latest/download/spry-sqlpage_rockylinux9.rpm

# Install
sudo rpm -i spry-sqlpage_rockylinux9.rpm

# Verify installation
spry-sqlpage --version
```

#### macOS

```bash
# Download and extract
wget https://github.com/programmablemd/packages/releases/latest/download/spry-sqlpage-macos.tar.gz
tar -xzf spry-sqlpage-macos.tar.gz

# Move to PATH
sudo mv spry-sqlpage /usr/local/bin/

# Verify installation
spry-sqlpage --version
```

#### Windows

1. Download `spry-sqlpage-windows.zip` from [releases](https://github.com/programmablemd/packages/releases/latest)
2. Extract the ZIP file
3. Add the extracted directory to your PATH
4. Open a new terminal and run: `spry-sqlpage --version`

## For Developers

### Build from Source

#### Prerequisites

```bash
# Install Docker
curl -fsSL https://get.docker.com | sh

# Verify Docker is running
docker --version
docker buildx version
```

#### Clone and Build

```bash
# Clone the repository
git clone https://github.com/programmablemd/packages.git
cd packages

# Build all packages
make build-all

# Or build for specific platform
make build-jammy
```

#### Local Development

```bash
# Install Deno
curl -fsSL https://deno.land/install.sh | sh

# Compile locally
make compile-local

# Test the binary
./spry-sqlpage --help
```

### Quick Build Commands

```bash
# Build DEB for Ubuntu
make build-jammy

# Build RPM for Rocky Linux
make build-rocky

# Build Windows package
make build-windows

# Clean build artifacts
make clean
```

## Using Spry SQLPage

Once installed, you can use spry-sqlpage to create web applications:

```bash
# Get help
spry-sqlpage --help

# Run your Spry application
spry-sqlpage serve

# For more information, visit:
# https://github.com/programmablemd/spry
```

## Troubleshooting

### Package Installation Fails

**Ubuntu/Debian:**
```bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y ca-certificates

# Try installing again
sudo dpkg -i spry-sqlpage_jammy.deb
```

**Rocky/Alma Linux:**
```bash
# Install dependencies
sudo yum install -y ca-certificates

# Try installing again
sudo rpm -i spry-sqlpage_rockylinux9.rpm
```

### Binary Not Found After Installation

```bash
# Check if binary exists
which spry-sqlpage

# If not found, add to PATH
export PATH=$PATH:/usr/local/bin

# Make it permanent (add to ~/.bashrc or ~/.zshrc)
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc
```

### Build Fails

```bash
# Ensure Docker BuildKit is enabled
export DOCKER_BUILDKIT=1

# Clean and rebuild
make clean
make build-all
```

## Next Steps

- Read the [full documentation](README.md)
- Check out [build instructions](BUILD.md)
- Learn about [contributing](CONTRIBUTING.md)
- Explore the [architecture](ARCHITECTURE.md)

## Getting Help

- [Open an issue](https://github.com/programmablemd/packages/issues)
- [Spry Documentation](https://github.com/programmablemd/spry)
- [DALEC Documentation](https://project-dalec.github.io/dalec/)

