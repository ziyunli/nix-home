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

  macTools = with pkgs.darwin.apple_sdk.frameworks; [
    CoreServices
    Foundation
    Security
  ];

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
    python3
  ];

  rubyTools = with pkgs; [
    shadowenv
  ];
in
gitTools
++ macTools
++ misc
++ nixTools
++ rustTools
++ pythonTools
++ rubyTools
