# vi: ft=sh

autoload -Uz promptinit; promptinit
autoload -Uz compinit; compinit
autoload -Uz bashcompinit; bashcompinit

eval "$(/opt/homebrew/bin/brew shellenv)"

# Deduplicating $PATH in tmux
typeset -aU path

# prompt pure
eval "$(starship init zsh)"

# Prefer GNU utils
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/etc/paths.d:$PATH

# Curl
export PATH=$(brew --prefix curl)/bin:$PATH


# zstyle ':completion:*' hosts off
# Git
zstyle ':completion:*:*:git:*' script "$HOME/.zsh/completion/git-completion.bash"
fpath=("$HOME/.zsh" $fpath)

# Use "emacs" mode
# bindkey -e
set -o emacs

################################################################################
# Pulled from thoughtbot dotfiles
################################################################################
# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

################################################################################
# End - Pulled from thoughtbot dotfiles
################################################################################

export EDITOR=nvim

# Git
export GIT_EDITOR=nvim

# Elixir
export KERL_BUILD_DOCS="yes"

# Postgres
# export PGDATA='/usr/local/var/postgres'
# export PGHOST=localhost

# FZF
export FZF_DEFAULT_COMMAND='rg --files'

# Python
# export PATH="/opt/homebrew/anaconda3/bin:$PATH"  # commented out by conda initialize

# Ruby
export DISABLE_SPRING=1
export PATH="/usr/local/opt/libpq/bin:$PATH"

# Highwing
export BUNDLE_GITHUB__COM="$(op read 'op://Engineering/Github Token/Engineering/credential')"
export GITHUB_TOKEN=$BUNDLE_GITHUB__COM
export BUNDLE_RUBYGEMS__PKG__GITHUB__COM=$BUNDLE_GITHUB__COM

source "$HOME/.aliases"

# asdf (readme insists this be after path export)
if [ -d $HOME/.asdf ]
then
  if test -f $HOME/.asdf/asdf.sh; then
    source $HOME/.asdf/asdf.sh
    source $HOME/.asdf/completions/asdf.bash
  fi

  if test -f "$(brew --prefix asdf)/libexec/asdf.sh"; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
    source "$(brew --prefix asdf)/etc/bash_completion.d/asdf"
  fi

  ## append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  ## initialise completions with ZSH's compinit
  autoload -Uz compinit
  compinit
fi
