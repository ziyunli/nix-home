{ homeDirectory
, pkgs
}:

let
  gitTools = with pkgs;
    [ diff-so-fancy gitflow tig difftastic git-annex git-crypt ];

  # macOS frameworks are typically not needed in home-manager user packages
  # They are used for building software, not as user-facing tools
  macTools = [ ];

  misc = with pkgs; [
    # _1password
    coreutils
    fd
    findutils
    hugo # for initializing projects
    openssl
    tree
    wget
  ];

  nixTools = with pkgs; [
    cachix
    lorri
  ];

  rustTools = with pkgs; [
    rustup # for things like `cargo init`
  ];

  dataTools = with pkgs; [
    redis
  ];
in
gitTools
++ macTools
++ misc
++ nixTools
++ rustTools
++ dataTools
