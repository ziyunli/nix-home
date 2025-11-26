{ homeDirectory
, pkgs
}:

{
  enable = true;
  package = pkgs.gitFull;

  lfs = { enable = true; };

  ignores = [
    ".cache/"
    ".DS_Store"
    ".direnv/"
    ".idea/"
    "*.swp"
    "built-in-stubs.jar"
    "dumb.rdb"
    ".elixir_ls/"
    ".vscode/"
    "npm-debug.log"
  ];
  # aliases = (import ./aliases.nix { inherit homeDirectory; }).git;

  settings = {
    user = {
      name = "Ziyun Li";
      email = "me@ziyunli.dev";
    };

    core = {
      editor = "nvim";
      whitespace = "trailing-space,space-before-tab";
    };

    credential.helper = "osxkeychain";
    pull.rebase = "false";
    init.defaultBranch = "main";
  };
}
