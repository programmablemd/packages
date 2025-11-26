# Contributing to Spry DALEC Packages

Thank you for your interest in contributing to the Spry DALEC packaging project!

## How to Contribute

### Reporting Issues

If you encounter any issues with the packages:

1. Check if the issue already exists in the [Issues](https://github.com/programmablemd/packages/issues) section
2. If not, create a new issue with:
   - A clear title and description
   - Steps to reproduce the problem
   - Expected vs actual behavior
   - Your operating system and version
   - Package version you're using

### Submitting Changes

1. Fork the repository
2. Create a new branch for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes
4. Test your changes locally:
   ```bash
   make build-all
   ```
5. Commit your changes with a clear message:
   ```bash
   git commit -m "Add: description of your changes"
   ```
6. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
7. Create a Pull Request

### Development Setup

#### Prerequisites

- Docker with BuildKit support
- Docker Buildx
- Make (optional, for convenience)
- Deno (for local testing)

#### Building Locally

```bash
# Build all packages
make build-all

# Build specific platform
make build-jammy
make build-rocky
make build-windows

# Compile locally with Deno
make compile-local
```

#### Testing

```bash
# Test the compiled binary
make test

# Install locally for testing
make install

# Uninstall
make uninstall
```

### Code Style

- Use clear, descriptive commit messages
- Follow YAML best practices in DALEC specs
- Keep the README.md up to date
- Document any new features or changes

### Pull Request Guidelines

- Keep PRs focused on a single feature or fix
- Update documentation as needed
- Ensure all builds pass
- Reference any related issues

## Questions?

If you have questions, feel free to:
- Open an issue for discussion
- Check the [DALEC documentation](https://project-dalec.github.io/dalec/)
- Review the [Spry project](https://github.com/programmablemd/spry)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

