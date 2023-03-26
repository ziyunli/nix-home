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

  nixTools = with pkgs; [
    cachix
    lorri
  ];

  rustTools = with pkgs; [
    rustup # for things like `cargo init`
  ];
in
gitTools
++ nixTools
++ rustTools
