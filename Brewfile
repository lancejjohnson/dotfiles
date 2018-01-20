tap "caskroom/cask"
tap "caskroom/fonts"
tap "caskroom/versions"
tap "homebrew/bundle"
tap "homebrew/core"
tap "homebrew/services"
tap "homebrew/versions"
tap "thoughtbot/formulae"
tap "universal-ctags/universal-ctags"

# System
# TODO: Add this as a command to add to bashrc or zshrc if it's not there
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew "openssl" # LEAVE THIS AT THE TOP!
brew "coreutils"
brew "findutils"
brew "moreutils"

brew "bash" # Install bash 4
brew "bash-completion2"
brew "chromedriver", restart_service: true
brew "dark-mode"
brew "exercism"
brew "git"
brew "git-lfs"
brew "gnu-sed", args: ["with-default-names"]
brew "heroku"
brew "imagemagick"
brew "libyaml" # should come after openssl
brew "pandoc"
brew "rcm"
brew "reattach-to-user-namespace" # Fixes tmux macOS issues
brew "the_silver_searcher"
brew "tmux"
brew "tree"
brew "universal-ctags", args: ["HEAD"]
brew "watchman"
brew "webkit2png"
brew "wget", args: ["with-iri"]
brew "zsh"

# Containers and VMs
brew "virtualbox"
brew "vagrant"
brew "docker"
brew "openshift-cli"

# Editors
brew "macvim", args: ["with-override-system-vim"]
brew "emacs", args: ["with-cocoa"]

# Ruby
brew "chruby"
brew "ruby-install"
brew "qt@5.5", link: true

# Python
brew "python"
brew "python3"

# Elixir
brew "erlang"

# Golang
brew "go"

# JavaScript
brew "node"
brew "phantomjs"
brew "yarn"

# Datastores
brew "mysql"
brew "postgresql", restart_service: :changed
brew "redis", restart_service: :changed

# Other
brew "exercism"

# Misc I had installed
# brew "gmp@4"
# brew "cloog", link: false
# brew "cscope"
# brew "mpfr@2"
# brew "libmpc@0.8"
# brew "gcc@4.9"
# brew "libffi"
# brew "gnupg"
# brew "isl@0.11"
# brew "jq"
# brew "libevent"
# brew "readline", link: true
# brew "pkg-config"
# brew "qt"
# brew "unixodbc"
# brew "xhyve", args: ["HEAD"]
