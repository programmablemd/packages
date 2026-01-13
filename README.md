# Spry DALEC Packages

This repository contains DALEC-generated packages for `spry`, providing native installation options across multiple platforms.

## About

Spry is a declarative web application framework built on Deno. This repository uses [DALEC](https://github.com/project-dalec/dalec) to build secure, cross-platform packages.

## Installation

### 📦 Package Managers (Recommended)

#### Homebrew (macOS & Linux)

### Option 1: Install directly (without tapping)

```bash
brew install programmablemd/packages/spry
```

### Option 2: Install from this tap

```bash
# Add the tap
brew tap programmablemd/homebrew-packages

# Install spry
brew install spry
```

For additional Homebrew installation options, including installing specific versions and upgrading, please refer to [HOMEBREW.md](HOMEBREW.md).

#### Ubuntu/Debian (.deb packages)

```bash
# Ubuntu 22.04 (Jammy)
wget https://github.com/programmablemd/packages/releases/download/v1.5.0/spry_1.5.0-ubuntu22.04u1_amd64.deb
sudo dpkg -i spry_1.5.0-ubuntu22.04u1_amd64.deb

# Debian 12 (Bookworm)
wget https://github.com/programmablemd/packages/releases/download/v1.5.0/spry_1.5.0-debian12u1_amd64.deb
sudo dpkg -i spry_1.5.0-debian12u1_amd64.deb
```

#### macOS (Manual Installation)

If you prefer not to use Homebrew:

```bash
# Download and extract
wget https://github.com/programmablemd/packages/releases/download/v1.5.0/spry-macos.tar.gz
tar -xzf spry-macos.tar.gz
sudo mv spry-macos /usr/local/bin/spry
```

#### Windows

```powershell
# Download the Windows package
# https://github.com/programmablemd/packages/releases/download/v1.5.0/spry-windows.zip

# Extract the zip file and run:
.\spry.exe --help
```

### 🔗 Direct Download

Visit our [GitHub Releases](https://github.com/programmablemd/packages/releases) page to download pre-built binaries for your operating system:

- **Windows**: `spry-windows.zip`
- **macOS**: `spry-macos.tar.gz`
- **Linux DEB**: `spry_jammy.deb`, `spry_bookworm.deb`

## Verification

After installation, verify that `spry` is working correctly:

```bash
spry --version
spry --help
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

