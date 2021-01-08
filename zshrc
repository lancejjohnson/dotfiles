# vi: ft=sh

autoload -U promptinit; promptinit
# prompt spaceship
# prompt pure
eval "$(starship init zsh)"

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="$HOME/.cask/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# zstyle ':completion:*' hosts off
# Git
zstyle ':completion:*:*:git:*' script "$HOME/.zsh/completions/git-completion.bash"
fpath=("$HOME/.zsh" $fpath)

autoload -Uz compinit && compinit

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

# Golang
# if [ -d $HOME/Code/go ]
# then
#   export GOPATH=$HOME/Code/go
# else
#   export GOPATH=$HOME/go
# fi
# if [ -d /usr/local/opt/go/libexec ]
# then
#   export GOROOT=/usr/local/opt/go/libexec
# else
#   export GOROOT=/usr/lib/golang
# fi
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin

# Postgres
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost

# FZF
export FZF_DEFAULT_COMMAND='rg --files'

source "$HOME/.aliases"

export PATH="$HOME/.bin:$PATH"

# Ruby
export DISABLE_SPRING=1

# asdf (readme insists this be after path export)
if [ -d $HOME/.asdf ]
then
  source $HOME/.asdf/asdf.sh
fi
