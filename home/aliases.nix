{ homeDirectory }:

{
  shell = {
    # git; from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
    gco = "git checkout";
    gcb = "git checkout -b";
    gcm = "git checkout $(git_main_branch)";
    gl = "git pull";
    gp = "git push";
    grbm = "git rebase $(git_main_branch)";

    # tig; from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/tig/tig.plugin.zsh
    tis = "tig status";
    til = "tig log";
    tib = "tig blame -C";

    # fzf based alias
    preview = "fzf --preview 'bat --color \"always\" {}'";

  };
}
