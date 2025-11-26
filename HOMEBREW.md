# Homebrew Installation

This repository can be used as a Homebrew tap to install `spry-sqlpage` on macOS and Linux.

## Installation

### Option 1: Install from this tap

```bash
# Add the tap
brew tap programmablemd/packages https://github.com/programmablemd/packages

# Install spry-sqlpage
brew install spry-sqlpage
```

### Option 2: Install directly (without tapping)

```bash
brew install programmablemd/packages/spry-sqlpage
```

## Usage

After installation, you can use the `spry-sqlpage` command:

```bash
spry-sqlpage --help
spry-sqlpage --version
```

## Updating

To update to the latest version:

```bash
brew update
brew upgrade spry-sqlpage
```

## Uninstalling

```bash
brew uninstall spry-sqlpage
```

## Supported Platforms

- **macOS**: Intel (x86_64) and Apple Silicon (ARM64)
- **Linux**: Ubuntu/Debian-based distributions (x86_64)

## Notes

- The formula automatically detects your platform and installs the appropriate binary
- On macOS, it installs the native macOS binary
- On Linux, it extracts and installs from the DEB package

## Troubleshooting

If you encounter issues:

1. Make sure Homebrew is up to date:
   ```bash
   brew update
   ```

2. Try reinstalling:
   ```bash
   brew uninstall spry-sqlpage
   brew install spry-sqlpage
   ```

3. Check the formula:
   ```bash
   brew info spry-sqlpage
   ```

## Manual Installation

If you prefer not to use Homebrew, you can download the binaries directly from the [releases page](https://github.com/programmablemd/packages/releases).

