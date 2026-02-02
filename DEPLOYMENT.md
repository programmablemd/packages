# Deployment Guide

This guide explains how to deploy the Spry DALEC project to GitHub and create your first release.

## Prerequisites

- Git installed
- GitHub account
- Docker with BuildKit (for local testing)
- Repository created on GitHub

## Step 1: Initialize Git Repository

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Spry SQLPage DALEC packaging"
```

## Step 2: Create GitHub Repository

1. Go to https://github.com/new
2. Create a new repository named `packages` (or your preferred name)
3. Do NOT initialize with README, .gitignore, or license (we already have these)

## Step 3: Push to GitHub

```bash
# Add remote
git remote add origin https://github.com/programmablemd/packages.git

# Push to main branch
git branch -M main
git push -u origin main
```

## Step 4: Update Documentation

Before creating a release, update the following files with your actual GitHub username:

### Files to Update

1. **README.md**
   - Replace `YOUR_USERNAME` with your GitHub username
   - Update download URLs

2. **QUICKSTART.md**
   - Replace `YOUR_USERNAME` with your GitHub username
   - Update download URLs

3. **CONTRIBUTING.md**
   - Replace `YOUR_USERNAME` with your GitHub username
   - Update repository URLs

```bash
# Quick find and replace (Linux/macOS)
find . -type f -name "*.md" -exec sed -i 's/YOUR_USERNAME/programmablemd/g' {} +

# Or manually edit each file
```

## Step 5: Test Locally (Optional but Recommended)

```bash
# Test local compilation
make compile-local

# Test the binary
./spry --help

# If you have Docker with BuildKit, test a build
make build-jammy
```

## Step 6: Create First Release

### Option A: Using the Release Script

```bash
# Make sure the script is executable
chmod +x scripts/release.sh

# Create release v0.1.0
./scripts/release.sh 0.1.0

# Push changes and tag
git push origin main
git push origin v0.1.0
```

### Option B: Manual Release

```bash
# Update version in dalec-spry.yaml if needed
# Then commit and tag
git add .
git commit -m "Release v0.1.0"
git tag -a v0.1.0 -m "Release version 0.1.0"

# Push
git push origin main
git push origin v0.1.0
```

## Step 7: Monitor GitHub Actions

1. Go to your repository on GitHub
2. Click on "Actions" tab
3. Watch the build workflow run
4. Verify all jobs complete successfully

The workflow will:

- Build DEB packages (Ubuntu, Debian) for spry
- Build Windows packages (cross-compiled)
- Build macOS packages (native)
- Create a GitHub Release with all artifacts

## Step 8: Verify Release

1. Go to your repository's "Releases" page
2. Verify the v0.1.0 release was created
3. Check that all package artifacts are attached:
   - `spry_jammy.deb`, `spry_bookworm.deb`
   - `spry-windows.zip`
   - `spry-macos.tar.gz`

## Step 9: Test Installation

Download and test a package for your platform:

### Ubuntu/Debian

```bash
wget https://github.com/programmablemd/packages/releases/download/v1.7.7/spry_jammy.deb
sudo dpkg -i spry_jammy.deb
spry --help
```

## Troubleshooting

### GitHub Actions Fails

1. Check the Actions tab for error messages
2. Common issues:
   - Docker BuildKit not available (should be available in GitHub runners)
   - Syntax errors in YAML files
   - Permission issues (check repository settings)

### Release Not Created

1. Verify the tag was pushed: `git push origin v0.1.0`
2. Check that the tag starts with 'v' (required by workflow)
3. Verify the workflow has `release` job enabled

### Packages Not Attached to Release

1. Check the workflow logs for upload errors
2. Verify artifacts were created in build jobs
3. Check GitHub token permissions

## Continuous Deployment

After the initial setup, the workflow will automatically:

1. **On push to main**: Build and test packages
2. **On new tag (v*)**: Build, test, and create release
3. **On pull request**: Build and test packages

## Updating Versions

To release a new version:

```bash
# Update version
./scripts/release.sh 0.2.0

# Push
git push origin main
git push origin v0.2.0
```

## Security Considerations

1. **Secrets**: No secrets are required for basic builds
2. **Permissions**: The workflow uses `GITHUB_TOKEN` automatically
3. **Signing**: Consider adding GPG signing for production releases

## Next Steps

1. ✅ Repository deployed
2. ✅ First release created
3. ✅ Packages available for download
4. 📢 Announce the release
5. 📝 Update documentation as needed
6. 🐛 Monitor issues and feedback
7. 🚀 Plan next features

## Support

If you encounter issues:
- Check the [BUILD.md](BUILD.md) for build instructions
- Review [ARCHITECTURE.md](ARCHITECTURE.md) for design details
- Open an issue on GitHub
- Check DALEC documentation: https://project-dalec.github.io/dalec/

---

**Congratulations!** 🎉 Your Spry SQLPage DALEC project is now deployed and ready for users!

