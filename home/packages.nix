{ homeDirectory
, pkgs
}:

let
  gitTools = with pkgs.gitAndTools;
    [ diff-so-fancy git-codeowners gitflow lucky-commit tig ]
    ++ (with pkgs; [
      difftastic
      git-annex
      git-crypt
    ]);

  misc = with pkgs; [
    # _1password
    coreutils
    fd
    findutils
    hugo # for initializing projects
    nodejs-18_x # for global npm and npx
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

  pythonTools = with pkgs; [
    conda
    mamba
    micromamba
  ];
in
gitTools
++ misc
++ nixTools
++ rustTools
++ pythonTools
