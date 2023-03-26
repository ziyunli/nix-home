{ homeDirectory
, pkgs
}:

let
  gitTools = with pkgs.gitAndTools;
    [ diff-so-fancy git-codeowners gitflow tig ]
    ++ (with pkgs; [
      difftastic
      git-annex
      git-crypt
    ]);

  misc = with pkgs; [
    hugo # for initializing projects
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
++ misc
++ nixTools
++ rustTools
