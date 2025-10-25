# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

See [README.md](./README.md)

## Architecture

This is a Nix home-manager configuration for macOS (aarch64-darwin) that uses a modular architecture:

- **flake.nix**: Defines inputs and outputs, creates both darwinConfigurations and homeConfigurations
- **home/default.nix**: Main entry point that imports all other modules
- **home/packages.nix**: Centralized package management organized by categories (git, mac, misc, nix, rust, data)
- **home/programs.nix**: Program-specific configurations that delegate to individual files

### Key Design Patterns

1. **Modular Configuration**: Each program (git, neovim, starship, zsh) has its own configuration file for maintainability
2. **Overlay Integration**: Uses overlays to integrate rust-overlay and nix-init packages into nixpkgs
3. **Darwin Integration**: Leverages nix-darwin for macOS-specific configurations and system management
4. **Development Focus**: Includes comprehensive development tooling for Nix, Rust, and general programming

### Important Notes

- Nix is installed via [Determinate](https://docs.determinate.systems/)
- The username "ziyunli" is hardcoded in several places (flake.nix, home/default.nix)
- Shell aliases are maintained in home/aliases.nix and integrated via zsh configuration
- The configuration assumes an Apple Silicon Mac (aarch64-darwin)
- Development shell provides convenience scripts that wrap common operations

#### Homebrew-Managed Packages

Some tools are still managed via Homebrew instead of Nix:

- **nvm** - Node Version Manager with auto-switching via `.nvmrc` files
- **rbenv** - Ruby version manager

These are initialized in `home/scripts/init.sh` and integrated into the shell environment.
