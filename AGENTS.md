# Project Instructions

## Project Structure

- `src/`: Source code directory.
- `notebooks/`: Exploratory code directory.

## Development Guidelines

### Dependency Management

- Run `uv sync` to install dependencies.
- Run `uv run ...` instead of `python ...` to use the virtual environment.

### Code Style

- Use modern Python practices (Type hints, etc.).
- Format and lint the code using Ruff: `uv run ruff check . --fix` and `uv run ruff format .`.
