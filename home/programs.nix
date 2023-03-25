{ homeDirectory
, pkgs
}:

{
  # Fancy replacement for cat
  bat.enable = true;

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

  # Replacement for ls
  exa = {
    enable = true;
    enableAliases = true;
  };

  # Fuzzy finder
  fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # The GitHub CLI
  gh = {
    enable = true;
    settings = {
      editor = "vim";
      git_protocol = "ssh";
      prompt = "enabled";
      # aliases = (import ./aliases.nix { inherit homeDirectory; }).githubCli;
    };
  };

  # But of course
  git = import ./git.nix { inherit homeDirectory pkgs; };

  home-manager = {
    enable = true;
  };

  # JSON parsing on the CLI
  jq.enable = true;

  # For Git rebases and such
  neovim = import ./neovim.nix {
    inherit (pkgs) vimPlugins;
  };

  # Speed up nix search functionality
  nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  starship = import ./starship.nix;

  zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  zsh = import ./zsh.nix {
    inherit homeDirectory;
    inherit (pkgs) substituteAll;
  };
}
