# Default target
.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make init        Initialize project (rename if args provided, install dependencies & hooks)"
	@echo "                   Usage example: make init NAME=my-awesome-project PKG=my_lib"
	@echo "  make dev-build   Build development Docker image"
	@echo "  make prod-build  Build runtime Docker image"

# --- Variables ---
PROJECT_NAME := my-awesome-project
SRC_DIR := src
# Current default package name
OLD_PKG_NAME := my_lib
# Current project name in pyproject.toml
OLD_PROJECT_NAME := my-lib

# Variables can be overridden via command line
NAME ?= $(PROJECT_NAME)
PKG ?= $(OLD_PKG_NAME)

# --- Platform Compatibility ---
OS := $(shell uname -s)
ifeq ($(OS),Darwin)
	SED_CMD := sed -i ''
else
	SED_CMD := sed -i
endif

# --- Commands ---

.PHONY: init
init:
	@# 1. Rename Project (if arguments provided and different)
	@if [ "$(NAME)" != "$(PROJECT_NAME)" ] || [ "$(PKG)" != "$(OLD_PKG_NAME)" ]; then \
		echo "🚀 Renaming project to $(NAME) / $(PKG)..."; \
		if [ -d "$(SRC_DIR)/$(OLD_PKG_NAME)" ]; then \
			mv "$(SRC_DIR)/$(OLD_PKG_NAME)" "$(SRC_DIR)/$(PKG)"; \
		fi; \
		$(SED_CMD) 's/name = "$(OLD_PROJECT_NAME)"/name = "$(NAME)"/' pyproject.toml; \
		$(SED_CMD) 's|packages = \["src/$(OLD_PKG_NAME)"\]|packages = ["src/$(PKG)"]|' pyproject.toml; \
	else \
		echo "ℹ️  No name change detected (use NAME=... PKG=... to rename). Proceeding with setup..."; \
	fi
	@# 2. Install Dependencies
	@echo "📦 Installing dependencies with uv..."
	@uv sync --all-extras
	@# 3. Install Pre-commit
	@echo "⚓️ Installing pre-commit hooks..."
	@uv run pre-commit install
	@echo "✅ Initialization complete!"

.PHONY: dev-build
dev-build:
	docker build -t $(NAME):dev -f dev.dockerfile .

.PHONY: prod-build
prod-build:
	docker build -t $(NAME):runtime -f runtime.dockerfile .
