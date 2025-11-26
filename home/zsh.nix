{ homeDirectory
, substituteAll
}:

{
  enable = true;
  autosuggestion = { enable = true; };
  enableCompletion = true;
  autocd = false;
  initContent = (builtins.readFile ./scripts/init.sh);
  shellAliases = (import ./aliases.nix { inherit homeDirectory; }).shell;

  oh-my-zsh = {
    enable = true;
    plugins = [
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
      "macos"
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
      "colored-man-pages"
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
      "git"
      "gitfast"
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitignore
      "gitignore"
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tig
      "tig"
    ];
    theme = "robbyrussell";
  };
}
