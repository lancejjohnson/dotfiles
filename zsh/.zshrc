# vi: ft=sh

autoload -Uz promptinit; promptinit
autoload -Uz compinit; compinit
autoload -Uz bashcompinit; bashcompinit

eval "$(/opt/homebrew/bin/brew shellenv)"

# Deduplicating $PATH in tmux
typeset -aU path

# prompt pure
eval "$(starship init zsh)"

export KITTY_CONFIG_DIRECTORY="$HOME/.config/kitty"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="$HOME/.cask/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH=/etc/paths.d:$PATH

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

# Golang
if [ -d $HOME/code/go ]
then
  export GOPATH=$HOME/code/go
else
  export GOPATH=$HOME/go
fi
if [ -d /opt/homebrew/opt/go/libexec ]
then
  export GOROOT=/opt/homebrew/opt/go/libexec
else
  export GOROOT=/usr/lib/golang
fi
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

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

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME.asdf/installs/rust/1.63.0/bin:$PATH"

# Scala
export PATH="$HOME/Library/Application Support/Coursier/bin:$PATH"

# Highwing
export BUNDLE_GITHUB__COM="$(op read 'op://Engineering/Github Token/Engineering/credential')"
export GITHUB_TOKEN=$BUNDLE_GITHUB__COM

source "$HOME/.aliases"

complete -F _todo t





# asdf (readme insists this be after path export)
if [ -d $HOME/.asdf ]
then
  if test -f $HOME/.asdf/asdf.sh; then
    source $HOME/.asdf/asdf.sh
    source $HOME/.asdf/completions/asdf.bash
  fi

  if test -f "$(brew --prefix asdf)/libexec/asdf.sh"; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
    source "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
  fi

  ## append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  ## initialise completions with ZSH's compinit
  autoload -Uz compinit
  compinit
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

