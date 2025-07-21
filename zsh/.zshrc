# vi: ft=sh

autoload -Uz promptinit; promptinit
autoload -Uz compinit; compinit
autoload -Uz bashcompinit; bashcompinit

eval "$(/opt/homebrew/bin/brew shellenv)"

# Deduplicating $PATH in tmux
typeset -aU path

# prompt pure
eval "$(starship init zsh)"

# activate mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

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

# # Highwing
# export BUNDLE_GITHUB__COM="$(op read 'op://Engineering/Github Token/Engineering/credential')"
# export GITHUB_TOKEN=$BUNDLE_GITHUB__COM
# export BUNDLE_RUBYGEMS__PKG__GITHUB__COM=$BUNDLE_GITHUB__COM

source "$HOME/.aliases"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/lance/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
export PATH="/opt/homebrew/opt/ffmpeg@6/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# ASDF
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

export MANWIDTH=80
