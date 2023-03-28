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
    flake-utils.url = "github:numtide/flake-utils";
    devenv.url = "github:cachix/devenv/latest";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , darwin
    , rust-overlay
    , nix-init
    , flake-utils
    , devenv
    }:
    let
      # Values you should modify
      username = "ziyunli"; # $USER
      system = "x86_64-darwin";  # x86_64-linux, aarch64-multiplatform, etc.
      stateVersion = "23.05";     # See https://nixos.org/manual/nixpkgs/stable for most recent

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

      # Helper functions
      run = pkg: "${pkgs.${pkg}}/bin/${pkg}";

      home = (import ./home {
        inherit homeDirectory pkgs stateVersion system username;
      });
    in {
      darwinConfigurations.${username} = darwin.lib.darwinSystem {
        inherit system;
        modules = [ (import ./nix-darwin) ];
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          home
        ];
      };
    }

    //

    flake-utils.lib.eachSystem [ system ] (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default =
        let
          format = pkgs.writeScriptBin "format" ''
            ${run "nixpkgs-fmt"} **/*.nix
          '';

          reload = pkgs.writeScriptBin "reload" ''
            ${run "nix"} build --no-sandbox .#homeConfigurations.${username}.activationPackage
            ./result/activate
          '';
        in
        pkgs.mkShell {
          packages = [ format reload pkgs.jq ];
        };

      packages.default = pkgs.dockerTools.buildImage {
        name = "nix-flakes";
        tag = "latest";
        fromImage = pkgs.dockerTools.pullImage {
          imageName = "nixos/nix";
          finalImageName = "nix";
          finalImageTag = "2.12.0pre20220901_4823067";
          imageDigest = "sha256:82da5bfe03f16bb1bc627af74e76b213fa237565c1dcd0b8d8ef1204d0960a59";
          sha256 = "sha256-sMdYw2HtUM5r5PP+gW1xsZts+POvND6UffKvvaxcv4M=";
        };

        config = {
          WorkingDir = "/app";

          Env = [
            "NIXPKGS_ALLOW_UNFREE=1"
          ];
        };
      };
    });
}
