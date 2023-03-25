{
  home-manager = {
    enable = true;
  };

  # Easy shell environments
  direnv = {
    enable = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;

    stdlib = ''
      use_riff() {
        watch_file Cargo.toml Cargo.lock
        eval "$(riff print-dev-env)"
      }
    '';
  };

  starship = import ./starship.nix;
}
