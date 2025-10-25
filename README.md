# Nix Home Manager Configuration

A modular Nix home-manager configuration for macOS (aarch64-darwin) with comprehensive development tooling for Nix, Rust, and general programming.

> **Note**: This configuration is based on [the-nix-way/nome](https://github.com/the-nix-way/nome).

## Prerequisites

- Nix installed via [Determinate Systems](https://docs.determinate.systems/)
- macOS on Apple Silicon (aarch64-darwin)
- Homebrew (for packages not managed by Nix)

## Quick Start

### Initial Setup

```sh
# Clone and build configuration
nix build '.#homeConfigurations.ziyunli.activationPackage'
./result/activate
```

### Development Workflow

```sh
# Enter development shell (provides format and reload scripts)
nix develop

# Build and activate using convenience script (recommended)
reload

# Format all nix files
format
```

### Common Operations

```sh
# Update all dependencies
nix flake update

# Update specific dependency
nix flake update <input-name>

# Build and activate manually
nix build '.#homeConfigurations.ziyunli.activationPackage' && ./result/activate
```

For architecture information, design patterns, and LLM-specific guidance, see [CLAUDE.md](./CLAUDE.md).
