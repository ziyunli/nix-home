# Nix Home Manager Configuration

A modular Nix home-manager configuration for macOS (aarch64-darwin) with comprehensive development tooling for Nix, Rust, and general programming.

> **Note**: This configuration is based on [the-nix-way/nome](https://github.com/the-nix-way/nome).

## Prerequisites

- Nix installed via [Determinate Systems](https://docs.determinate.systems/)
- macOS on Apple Silicon (aarch64-darwin)
- Homebrew (for packages not managed by Nix)
- [dotfiles](https://github.com/ziyunli/dotfiles) repo set up at `~/.dotfiles` (provides `~/.zshrc.common` with shared zsh/oh-my-zsh configuration)
- Clone [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#manual-installation)
- Clone [agkozak](https://github.com/agkozak/agkozak-zsh-prompt?tab=readme-ov-file#for-oh-my-zsh-users)

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
