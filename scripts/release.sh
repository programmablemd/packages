#!/bin/bash
set -e

# Release script for spry-sqlpage packages
# Usage: ./scripts/release.sh <version>

VERSION=$1

if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 0.1.0"
    exit 1
fi

# Validate version format
if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Version must be in format X.Y.Z (e.g., 0.1.0)"
    exit 1
fi

echo "Preparing release v$VERSION..."

# Update version in dalec-spry-sqlpage.yaml
echo "Updating version in dalec-spry-sqlpage.yaml..."
sed -i.bak "s/^version: .*/version: $VERSION/" dalec-spry-sqlpage.yaml
rm -f dalec-spry-sqlpage.yaml.bak

# Update version in README.md if needed
echo "Updating README.md..."
# Add any README updates here if needed

# Commit changes
echo "Committing version changes..."
git add dalec-spry-sqlpage.yaml README.md
git commit -m "Release v$VERSION" || echo "No changes to commit"

# Create and push tag
echo "Creating tag v$VERSION..."
git tag -a "v$VERSION" -m "Release version $VERSION"

echo ""
echo "Release v$VERSION prepared!"
echo ""
echo "To complete the release, run:"
echo "  git push origin main"
echo "  git push origin v$VERSION"
echo ""
echo "This will trigger the GitHub Actions workflow to build and publish packages."

