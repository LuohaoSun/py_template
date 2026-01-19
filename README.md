# My Awesome Project

My awesome project description.

## Features

- **⚡️ Modern Tooling**: `uv` for fast dependency management.
- **🛡️ Code Quality**: `ruff` (lint/format), `pyright` (types), and `pre-commit` hooks.
- **🐳 Docker Optimized**: Multi-stage builds, cache mounts, and cross-platform support.
- **✨ Dev Experience**: Ready-to-use `dev` container with code-server.

## Using this Template

To initialize a new project from this template:

1.  **Get the Code**: Download the repository as a ZIP file and extract it, or click **"Use this template"**.
2.  **Initialize**: Run the following command to rename the project and install dependencies:

```bash
make init NAME=your-project-name PKG=your_package_name
```

This command will:
- Rename `src/my_lib` to `src/your_package_name`.
- Update project metadata in `pyproject.toml`.
- Install dependencies and pre-commit hooks.

3.  **Update Documentation**: Update the title and description in this `README.md`.
