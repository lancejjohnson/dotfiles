" Heavily inspired/stolen from Drew Neil
" https://github.com/nelstrom/dotfiles

if !exists('*minpac#init')
  finish
endif

call minpac#init({'verbose': 0})

" minpac must have {'type': 'opt'} to be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" General enhancements
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('janko-m/vim-test')
call minpac#add('junegunn/vim-easy-align')
call minpac#add('kana/vim-smartinput')
call minpac#add('neomake/neomake')   
call minpac#add('ntpeters/vim-better-whitespace')
call minpac#add('scrooloose/nerdtree')
call minpac#add('scrooloose/syntastic')
call minpac#add('tpope/vim-characterize')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-cucumber')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-ragtag')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')

" General enhancements plugins to consider
" call minpac#add('tommcdo/vim-exchange') " direction commands for exchanging
" text places
" call minpac#add('tpope/vim-tbone') " tmux commands for vim
" call minpac#add('SirVer/ultisnips') " install later
" call minpac#add('jiangmiao/auto-pairs') " vim-smartinput same behavior?

" Custom textobjects
call minpac#add('kana/vim-textobj-user') " Must precede other textobj plugins
call minpac#add('kana/vim-textobj-entire')
call minpac#add('kana/vim-textobj-indent')
call minpac#add('andyl/vim-textobj-elixir')
call minpac#add('nelstrom/vim-textobj-rubyblock')
call minpac#add('b4winckler/vim-angry')

" Colors
call minpac#add('altercation/vim-colors-solarized', {'type': 'opt'})
call minpac#add('lifepillar/vim-solarized8', {'type': 'opt'})
call minpac#add('rakr/vim-one', {'type': 'opt'})

" Clojure
call minpac#add('guns/vim-clojure-highlight')
call minpac#add('guns/vim-clojure-static')
call minpac#add('guns/vim-sexp')
call minpac#add('kien/rainbow_parentheses.vim')
call minpac#add('tpope/vim-fireplace')
call minpac#add('tpope/vim-salve')
call minpac#add('tpope/vim-sexp-mappings-for-regular-people')
call minpac#add('venantius/vim-cljfmt')

" Go
call minpac#add('fatih/vim-go')

" Elixir
call minpac#add('elixir-lang/vim-elixir')
call minpac#add('avdgaag/vim-phoenix')

" JavaScript
call minpac#add('pangloss/vim-javascript')
call minpac#add('elzr/vim-json')
call minpac#add('mxw/vim-jsx')

" Markdown
call minpac#add('tpope/vim-markdown')
call minpac#add('nelstrom/vim-markdown-folding')
call minpac#add('junegunn/vim-emoji', {'type': 'opt'})

" Ruby
call minpac#add('tpope/vim-bundler')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rake')
call minpac#add('vim-ruby/vim-ruby')
call minpac#add('slim-template/vim-slim')
call minpac#add('ngmy/vim-rubocop')

