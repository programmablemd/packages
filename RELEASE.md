# Option A: Using the Release Script

Follow these steps to create and publish a new release using the provided release script.

## Steps

1. **Pull the latest changes from the repository**

   ```bash
   git pull origin main
   ```

2. **Create a new release**

   Run the release script with the version number (without the `v` prefix):

   ```bash
   ./scripts/release.sh 0.1.0
   ```

   This script will:

   * Update the necessary version references
   * Create a Git tag for the release

3. **Push changes and tags to the remote repository**

   ```bash
   git push origin main
   git push origin v0.1.0
   ```

4. **Update Homebrew formulas**

   After pushing the release, run the following command in the Homebrew packages repository to update the Spry formula:

   ```bash
   ./update-spry-formulas.sh v0.1.0
   ```
