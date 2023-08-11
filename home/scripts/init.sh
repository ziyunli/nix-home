# Nix setup
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Run the env.sh script (if it exists). That script is meant to contain secrets, tokens, and
# other things you don't want to put in your Nix config. This is quite "impure" but a
# reasonable workaround.
if [ -e ~/.env.sh ]; then
  . ~/.env.sh
fi

# Suppress direnv log output (which is super verbose and not that useful)
export DIRENV_LOG_FORMAT=

# Enable Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
alias brewski='brew update && brew upgrade && brew cleanup; brew doctor'

######################################################################################
# Functions
######################################################################################

# Generate .gitignore file
function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@;}


# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

######################################################################################
# FZF functions
######################################################################################

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
# Follow symbolic links, and don't want it to exclude hidden files
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function branches () {
  git branch --sort=-committerdate |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --preview="git log {} | bat --style=plain --color=always --line-range :500" |
    xargs git checkout
}

# from https://seb.jambor.dev/posts/improving-shell-workflows-with-fzf/
function delete-branches() {
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log {}" |
    xargs --no-run-if-empty git branch --delete --force
}
