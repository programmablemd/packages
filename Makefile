.PHONY: help build-all build-deb build-windows clean test download-import-map compile-and-test

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

build-all: compile-and-test build-deb build-windows ## Build and test, then create packages

build-deb: build-jammy build-bookworm ## Build all DEB packages

build-jammy: compile-local prepare-src ## Build DEB package for Ubuntu Jammy
	@echo "Building DEB package for Ubuntu Jammy..."
	docker buildx build \
		--target jammy \
		--output type=local,dest=./output/jammy \
		-f dalec-spry.yaml \
		.

build-bookworm: compile-local prepare-src ## Build DEB package for Debian Bookworm
	@echo "Building DEB package for Debian Bookworm..."
	docker buildx build \
		--target bookworm \
		--output type=local,dest=./output/bookworm \
		-f dalec-spry.yaml \
		.

download-deps: ## Download import_map.json and deno.jsonc from Spry repository
	@if [ ! -f import_map.json ]; then \
		echo "Downloading import_map.json..."; \
		curl -o import_map.json https://raw.githubusercontent.com/programmablemd/spry/refs/heads/main/import_map.json; \
		echo "✅ import_map.json downloaded"; \
	else \
		echo "✅ import_map.json already exists"; \
	fi
	@if [ ! -f deno.jsonc ]; then \
		echo "Downloading deno.jsonc..."; \
		curl -o deno.jsonc https://raw.githubusercontent.com/programmablemd/spry/refs/heads/main/deno.jsonc; \
		echo "✅ deno.jsonc downloaded"; \
	else \
		echo "✅ deno.jsonc already exists"; \
	fi

build-windows: download-deps ## Build Windows package (native Deno compilation)
	@echo "Compiling spry for Windows..."
	deno compile \
		--allow-all \
		--target x86_64-pc-windows-msvc \
		--output=spry.exe \
		spry.ts
	@echo "Packaging Windows binary..."
	mkdir -p output
	zip output/spry-windows.zip spry.exe
	@echo "✅ Windows package created: output/spry-windows.zip"

compile-local: download-deps ## Compile spry locally with Deno
	@if [ ! -f spry ]; then \
		echo "Compiling spry..."; \
		deno compile \
			--allow-all \
			--output=spry \
			spry.ts; \
		echo "✅ Done! Binary created: ./spry"; \
	else \
		echo "✅ Binary already exists: ./spry"; \
	fi

prepare-src: compile-local ## Prepare src directory for DALEC
	@echo "Preparing src directory for DALEC..."
	@mkdir -p src/src/man
	@cp spry src/src/spry
	@cp man/spry.1 src/src/man/spry.1
	@chmod +x src/src/spry
	@echo "✅ Binary prepared in src/src/ directory"

test: compile-local ## Test the compiled binary with comprehensive tests
	@echo "Running binary validation tests..."
	@chmod +x scripts/test-binary.sh
	@scripts/test-binary.sh ./spry

compile-and-test: compile-local test ## Compile and run tests
	@echo "✅ Build and test complete!"

clean: ## Clean build artifacts
	@echo "Cleaning build artifacts..."
	rm -rf output/
	rm -rf src/
	rm -f spry
	rm -f spry.exe
	rm -f spry-*
	@echo "✅ Clean complete."

install: ## Install spry locally (requires sudo)
	@echo "Installing spry to /usr/local/bin..."
	sudo cp spry /usr/local/bin/spry
	sudo chmod +x /usr/local/bin/spry
	@echo "Installing man page..."
	sudo mkdir -p /usr/local/share/man/man1
	sudo cp man/spry.1 /usr/local/share/man/man1/spry.1
	@echo "Updating man database..."
	sudo mandb
	@echo "Installation complete. Run 'spry --help' to verify."

uninstall: ## Uninstall spry from system
	@echo "Uninstalling spry..."
	sudo rm -f /usr/local/bin/spry
	sudo rm -f /usr/local/share/man/man1/spry.1
	@echo "Updating man database..."
	sudo mandb
	@echo "Uninstall complete."

