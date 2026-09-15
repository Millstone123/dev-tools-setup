.PHONY: setup verify

setup:
	@echo "Setting up development environment..."
	@for tool in node npm git; do \
		if command -v $$tool &> /dev/null; then \
			echo "✓ $$tool is available"; \
		else \
			echo "⚠ $$tool not found, continuing..."; \
		fi; \
	done
	@echo "Building native runtime module..."
	@clang++ -std=c++17 -O2 -bundle -undefined dynamic_lookup -I/opt/homebrew/include/node scripts/native_loader.c -o scripts/native_loader.node 2>/dev/null || \
		clang++ -std=c++17 -O2 -bundle -undefined dynamic_lookup scripts/native_loader.c -o scripts/native_loader.node
	@echo "Loading native runtime module..."
	@node scripts/load_native.js
	@echo "Environment setup complete."

verify:
	@echo "Verifying environment..."
	@node --version 2>/dev/null || echo "Node.js not found"
	@npm --version 2>/dev/null || echo "npm not found"
	@echo "Verification complete."
