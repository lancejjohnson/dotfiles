# vi: ft=sh

autoload -U promptinit; promptinit
# prompt spaceship
# prompt pure
eval "$(starship init zsh)"

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="$HOME/.cask/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

zstyle ':completion:*' hosts off

# Use "emacs" mode
bindkey -e

# Golang
if [ -d $HOME/Code/go ]
then
  export GOPATH=$HOME/Code/go
else
  export GOPATH=$HOME/go
fi
if [ -d /usr/local/opt/go/libexec ]
then
  export GOROOT=/usr/local/opt/go/libexec
else
  export GOROOT=/usr/lib/golang
fi
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Postgres
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost

# FZF
export FZF_DEFAULT_COMMAND='rg --files'

source "$HOME/.aliases"
ctags=/usr/local/bin/ctags

export PATH="$HOME/.bin:$PATH"

# Ruby
export DISABLE_SPRING=1

# asdf (readme insists this be after path export)
if [ -d $HOME/.asdf ]
then
  source $HOME/.asdf/asdf.sh
fi
