.PHONY: help build-all build-deb build-windows clean test

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

build-all: compile-local build-deb build-windows ## Build packages for all platforms

build-deb: build-jammy build-bookworm ## Build all DEB packages

build-jammy: compile-local prepare-src ## Build DEB package for Ubuntu Jammy
	@echo "Building DEB package for Ubuntu Jammy..."
	docker buildx build \
		--target jammy \
		--output type=local,dest=./output/jammy \
		-f dalec-spry-sqlpage.yaml \
		.

build-bookworm: compile-local prepare-src ## Build DEB package for Debian Bookworm
	@echo "Building DEB package for Debian Bookworm..."
	docker buildx build \
		--target bookworm \
		--output type=local,dest=./output/bookworm \
		-f dalec-spry-sqlpage.yaml \
		.

build-windows: ## Build Windows package (native Deno compilation)
	@echo "Compiling spry_sqlpage for Windows..."
	deno compile \
		--allow-all \
		--import-map=import_map.json \
		--target x86_64-pc-windows-msvc \
		--output=spry-sqlpage.exe \
		spry_sqlpage.ts
	@echo "Packaging Windows binary..."
	mkdir -p output
	zip output/spry-sqlpage-windows.zip spry-sqlpage.exe
	@echo "✅ Windows package created: output/spry-sqlpage-windows.zip"

compile-local: ## Compile spry_sqlpage locally with Deno
	@if [ ! -f spry-sqlpage ]; then \
		echo "Compiling spry_sqlpage..."; \
		deno compile \
			--allow-all \
			--import-map=import_map.json \
			--output=spry-sqlpage \
			spry_sqlpage.ts; \
		echo "✅ Done! Binary created: ./spry-sqlpage"; \
	else \
		echo "✅ Binary already exists: ./spry-sqlpage"; \
	fi

prepare-src: compile-local ## Prepare src directory for DALEC
	@echo "Preparing src directory for DALEC..."
	@mkdir -p src
	@cp spry-sqlpage src/spry-sqlpage
	@chmod +x src/spry-sqlpage
	@echo "✅ Binary prepared in src/ directory"

test: ## Test the compiled binary
	@echo "Testing spry-sqlpage binary..."
	./spry-sqlpage --help || echo "Binary not found. Run 'make compile-local' first."

clean: ## Clean build artifacts
	@echo "Cleaning build artifacts..."
	rm -rf output/
	rm -rf src/
	rm -f spry-sqlpage
	rm -f spry-sqlpage-*
	@echo "✅ Clean complete."

install: ## Install spry-sqlpage locally (requires sudo)
	@echo "Installing spry-sqlpage to /usr/local/bin..."
	sudo cp spry-sqlpage /usr/local/bin/spry-sqlpage
	sudo chmod +x /usr/local/bin/spry-sqlpage
	@echo "Installation complete. Run 'spry-sqlpage --help' to verify."

uninstall: ## Uninstall spry-sqlpage from system
	@echo "Uninstalling spry-sqlpage..."
	sudo rm -f /usr/local/bin/spry-sqlpage
	@echo "Uninstall complete."

