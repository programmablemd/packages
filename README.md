# Spry DALEC Packages

This repository contains DALEC-generated packages for `spry-sqlpage` and `spry-runbook`, providing native installation options across multiple platforms.

## About

Spry SQLPage is a declarative web application framework built on Deno. Spry Runbook is a runbook execution tool. This repository uses [DALEC](https://github.com/project-dalec/dalec) to build secure, cross-platform packages for both tools.

## Installation

### 📦 Package Managers (Recommended)

#### Homebrew (macOS & Linux)

```bash
# Install from tap
brew tap programmablemd/packages https://github.com/programmablemd/packages
brew install spry-sqlpage

# Or install directly without tapping
brew install programmablemd/packages/spry-sqlpage
```

See [HOMEBREW.md](HOMEBREW.md) for more details.

#### Ubuntu/Debian (.deb packages)

```bash
# Ubuntu 22.04 (Jammy)
wget https://github.com/programmablemd/packages/releases/download/v0.1.1/spry-sqlpage_0.1.0-ubuntu22.04u1_amd64.deb
sudo dpkg -i spry-sqlpage_0.1.0-ubuntu22.04u1_amd64.deb

# Debian 12 (Bookworm)
wget https://github.com/programmablemd/packages/releases/download/v0.1.1/spry-sqlpage_0.1.0-debian12u1_amd64.deb
sudo dpkg -i spry-sqlpage_0.1.0-debian12u1_amd64.deb
```

#### macOS (Manual Installation)

If you prefer not to use Homebrew:

```bash
# Download and extract
wget https://github.com/programmablemd/packages/releases/download/v0.1.1/spry-sqlpage-macos.tar.gz
tar -xzf spry-sqlpage-macos.tar.gz
sudo mv spry-sqlpage-macos /usr/local/bin/spry-sqlpage
```

#### Windows

```powershell
# Download the Windows packages
# https://github.com/programmablemd/packages/releases/download/v0.1.1/spry-sqlpage-windows.zip
# https://github.com/programmablemd/packages/releases/download/v0.1.1/spry-runbook-windows.zip

# Extract the zip files and run:
.\spry-sqlpage.exe --help
.\spry-runbook.exe --help
```

### 🔗 Direct Download

Visit our [GitHub Releases](https://github.com/programmablemd/packages/releases) page to download pre-built binaries for your operating system:

- **Windows**: `spry-sqlpage-windows.zip`, `spry-runbook-windows.zip`
- **macOS**: `spry-sqlpage-macos.tar.gz`, `spry-runbook-macos.tar.gz`
- **Linux DEB**: `spry-sqlpage_jammy.deb`, `spry-sqlpage_bookworm.deb`

## Verification

After installation, verify that `spry-sqlpage` and `spry-runbook` are working correctly:

```bash
spry-sqlpage --version
spry-sqlpage --help

spry-runbook --version
spry-runbook --help
```

## Building from Source

### Prerequisites

- Docker with BuildKit support
- Docker Buildx

### Build Commands

```bash
# Build DEB package for Ubuntu Jammy
docker buildx build \
  --target jammy \
  --output type=local,dest=./output \
  -f dalec-spry-sqlpage.yaml \
  .

# Build Windows package (cross-compilation)
docker buildx build \
  --target windowscross \
  --output type=local,dest=./output \
  -f dalec-spry-sqlpage.yaml \
  .
```

### Manual Compilation with Deno

```bash
# Download import_map.json
curl -o import_map.json https://raw.githubusercontent.com/programmablemd/spry/refs/heads/main/import_map.json

# Compile spry-sqlpage
deno compile \
  --allow-all \
  --import-map=import_map.json \
  --output=spry-sqlpage \
  spry_sqlpage.ts

# Compile spry-runbook
deno compile \
  --allow-all \
  --import-map=import_map.json \
  --output=spry-runbook \
  spry_runbook.ts
```

## Supported Platforms

- ✅ Ubuntu 22.04 (Jammy)
- ✅ Debian 12 (Bookworm)
- ✅ macOS (Intel & Apple Silicon)
- ✅ Windows (x64)

## Release Information

This repository is powered by [DALEC](https://github.com/project-dalec/dalec) for automated package generation and distribution. Each release includes:

- **Ubuntu packages** (.deb for jammy)
- **Debian packages** (.deb for bookworm)
- **Windows binaries** (.zip)
- **macOS binaries** (.tar.gz)

For the latest release notes, visit [GitHub Releases](https://github.com/programmablemd/packages/releases).

## License

This packaging repository is licensed under MIT. The Spry project has its own license.

## Links

- [Spry Project](https://github.com/programmablemd/spry)
- [DALEC Documentation](https://project-dalec.github.io/dalec/)
- [Deno](https://deno.land/)

