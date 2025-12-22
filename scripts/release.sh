#!/bin/bash
set -e

# Release script for spry packages
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

# Update version in dalec-spry.yaml
echo "Updating version in dalec-spry.yaml..."
sed -i.bak "s/^version: .*/version: $VERSION/" dalec-spry.yaml
rm -f dalec-spry.yaml.bak

# Update version in spry.ts (update both the constant and the import URL)
echo "Updating version in spry.ts..."
sed -i.bak -E "s|const VERSION = \"[0-9.]+\"|const VERSION = \"$VERSION\"|g" spry.ts
sed -i.bak -E "s|spry_private/v[0-9.]+/|spry_private/v$VERSION/|g" spry.ts
rm -f spry.ts.bak

# Update version in README.md (replace any version pattern in download URLs)
echo "Updating version in README.md..."
sed -i.bak -E "s|/v[0-9]+\.[0-9]+\.[0-9]+/|/v$VERSION/|g" README.md
sed -i.bak -E "s|_[0-9]+\.[0-9]+\.[0-9]+-|_${VERSION}-|g" README.md
rm -f README.md.bak

# Update version in QUICKSTART.md
echo "Updating version in QUICKSTART.md..."
sed -i.bak -E "s|/v[0-9]+\.[0-9]+\.[0-9]+/|/v$VERSION/|g" QUICKSTART.md
sed -i.bak -E "s|_[0-9]+\.[0-9]+\.[0-9]+-|_${VERSION}-|g" QUICKSTART.md
rm -f QUICKSTART.md.bak

# Update version in DEPLOYMENT.md
echo "Updating version in DEPLOYMENT.md..."
sed -i.bak -E "s|/v[0-9]+\.[0-9]+\.[0-9]+/|/v$VERSION/|g" DEPLOYMENT.md
sed -i.bak -E "s|_[0-9]+\.[0-9]+\.[0-9]+-|_${VERSION}-|g" DEPLOYMENT.md
rm -f DEPLOYMENT.md.bak

# Update version and date in man/spry.1 header
echo "Updating version and date in man/spry.1..."
CURRENT_DATE=$(date +"%B %Y")
# Update header line: .TH SPRY 1 "Date" "Version" "Manual Name"
sed -i.bak -E "s/^(\.TH SPRY 1 \")[^\"]+(\" \")[^\"]+(\".*)$/\1$CURRENT_DATE\2$VERSION\3/" man/spry.1
rm -f man/spry.1.bak

# Commit changes
echo "Committing version changes..."
git add dalec-spry.yaml spry.ts README.md QUICKSTART.md DEPLOYMENT.md man/spry.1
git commit -m "Release v$VERSION" || echo "No changes to commit"
git push origin main

# Create and push tag
echo "Creating tag v$VERSION..."
git tag -a "v$VERSION" -m "Release version $VERSION"

echo ""
echo "Release v$VERSION prepared!"
echo ""
# echo "To complete the release, run:"
# echo "  git push origin main"
# echo "  git push origin v$VERSION"
# echo ""
# echo "This will trigger the GitHub Actions workflow to build and publish packages."

# =======================================================
# GIT COMMIT & PUSH
# =======================================================
echo "📦 Committing changes to git..."

# git add .
git commit -m "Bump Spry formula to ${VERSION}"
git push origin "v$VERSION"

echo "🎉 All done! Spry new version updated, committed, and pushed!"