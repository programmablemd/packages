# Homebrew Installation

This repository can be used as a Homebrew tap to install `spry` on macOS and Linux.

## Installation

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

## Usage

After installation, you can use the `spry` command:

```bash
spry --help
spry --version
```

## Updating

To update to the latest version:

```bash
brew update
brew upgrade spry
```

## Install Specific Version

To install a specific version of spry:

### Option 1: Using version suffix

```bash
brew install programmablemd/packages/spry@0.102.1
```

### Option 2: Pin to prevent upgrades

After installing a specific version, you can pin it to prevent automatic upgrades:

```bash
brew pin spry
```

To unpin and allow upgrades again:

```bash
brew unpin spry
```

### Option 3: Switch between installed versions

If you have multiple versions installed:

```bash
brew unlink spry@0.102.1 && brew link spry@0.101.3
```

### Uninstalling

To remove the tool:

```bash
brew uninstall spry
```

To remove the tap:

```bash
brew untap programmablemd/homebrew-packages
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
   brew uninstall spry
   brew install spry
   ```

3. Check the formula:

   ```bash
   brew info spry
   ```

## Manual Installation

If you prefer not to use Homebrew, you can download the binaries directly from the [releases page](https://github.com/programmablemd/packages/releases).
