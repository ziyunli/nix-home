{ homeDirectory
, pkgs
, stateVersion
, system
, username }:

let
  # The packages to load into the PATH
  packages = import ./packages.nix { inherit homeDirectory pkgs; };
in {
  home = {
    inherit homeDirectory packages stateVersion username;

    enableNixpkgsReleaseCheck = false;

    shellAliases = {
      reload-home-manager-config = "home-manager switch --flake ${builtins.toString ./.}";
    };
  };

  nixpkgs = {
    config = {
      inherit system;
      allowUnfree = true;
      allowUnsupportedSystem = true;
      experimental-features = "nix-command flakes";
    };
  };

  # Configurations for programs directly supported by Home Manager
  programs = import ./programs.nix { inherit homeDirectory pkgs; };
}
