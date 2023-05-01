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

    # exa with extra options (extra args not supported yet in 22.11)
    # From https://github.com/nix-community/home-manager/blob/master/modules/programs/exa.nix
    ls = "exa";
    ll = "exa -l --group-directories-first --header --no-user --git --icons";
    la = "exa -a";
    lt = "exa --tree";
    lla = "exa -la --group-directories-first --header --no-user --git --icons";
  };
}
