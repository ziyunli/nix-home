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
    coreutils
    fd
    findutils
    hugo # for initializing projects
    nodejs-18_x # for global npm and npx
    openssl
    tree
    wget
    yt-dlp
  ];

  nixTools = with pkgs; [
    cachix
    lorri
  ];

  rustTools = with pkgs; [
    rustup # for things like `cargo init`
  ];
in
gitTools
++ macTools
++ misc
++ nixTools
++ rustTools
