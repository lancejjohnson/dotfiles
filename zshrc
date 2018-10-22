# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="$HOME/.cask/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

zstyle ':completion:*' hosts off

# Ruby
if [ -f /usr/local/share/chruby/chruby.sh ]
then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

# Elixir and Erlang
if [ -d $HOME/.exenv ]
then
  export PATH="$HOME/.exenv/bin:$PATH"
  eval "$(exenv init -)"
fi

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

## Red Hat Projects
export AMS=$GOPATH/src/gitlab.cee.redhat.com/service/uhc-account-manager
export UHC=$HOME/Code/redhat/cloud.openshift.com

# Postgres
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# FZF
export FZF_DEFAULT_COMMAND='rg --files'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
source "$HOME/.aliases"
ctags=/usr/local/bin/ctags

