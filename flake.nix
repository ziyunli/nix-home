{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
    nix-init.url = "github:nix-community/nix-init";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , darwin
    , rust-overlay
    , nix-init
    }:
    let
      # Values you should modify
      username = "ziyunli"; # $USER
      system = "aarch64-darwin";  # x86_64-linux, aarch64-multiplatform, etc.
      stateVersion = "22.11";     # See https://nixos.org/manual/nixpkgs/stable for most recent

      # System-specific Nixpkgs
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };

        overlays = [
          (import rust-overlay)
          (self: super: {
            nix-init = nix-init.packages.${system}.default;
          })
        ];
      };

      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
      homeDirectory = "/${homeDirPrefix}/${username}";

      home = (import ./home {
        inherit homeDirectory pkgs stateVersion system username;
      });
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          home
        ];
      };
    };
}
