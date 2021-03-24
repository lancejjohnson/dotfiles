" Heavily inspired/stolen from Drew Neil
" https://github.com/nelstrom/dotfiles
let g:has_async = v:version >= 800 || has('nvim')

if !exists('g:loaded_minpac')
  echo("minpac does not exist")
  finish
endif

call minpac#init({'verbose': 0})

" minpac must have {'type': 'opt'} to be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" General enhancements
call minpac#add('vim-test/vim-test')
call minpac#add('jremmen/vim-ripgrep')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/vim-easy-align')
call minpac#add('kana/vim-smartinput')
call minpac#add('ludovicchabant/vim-gutentags')
" call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('neomake/neomake')
call minpac#add('ntpeters/vim-better-whitespace')
call minpac#add('pbrisbin/vim-mkdir')
call minpac#add('tpope/vim-characterize')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-cucumber')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-ragtag')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-vinegar')

" Ranger
" call minpac#add('francoiscabrol/ranger.vim')
call minpac#add('kevinhwang91/rnvimr')

" UI
" call minpac#add('vim-airline/vim-airline')
" call minpac#add('vim-airline/vim-airline-themes')

" if g:has_async
"   call minpac#add('w0rp/ale')
" endif

" Colorscheme development
" call minpac#add('lifepillar/vim-colortemplate')

" tmux
" call minpac#add('christoomey/vim-tmux-runner')

" General enhancements plugins to consider
call minpac#add('tommcdo/vim-exchange') " direction commands for exchanging text places
" call minpac#add('tpope/vim-tbone') " tmux commands for vim
" call minpac#add('SirVer/ultisnips') " install later
" call minpac#add('jiangmiao/auto-pairs') " vim-smartinput same behavior?

" Custom textobjects
call minpac#add('kana/vim-textobj-user') " Must precede other textobj plugins
call minpac#add('kana/vim-textobj-entire')
call minpac#add('kana/vim-textobj-indent')
call minpac#add('nelstrom/vim-textobj-rubyblock')
call minpac#add('b4winckler/vim-angry')

" Colors
call minpac#add('arcticicestudio/nord-vim', {'type': 'opt'})
call minpac#add('jeffkreeftmeijer/vim-dim', {'type': 'opt'})
call minpac#add('lifepillar/vim-solarized8', {'type': 'opt'})
" call minpac#add('logico/typewriter-vim', {'type': 'opt'})
call minpac#add('lancejjohnson/typewriter-vim', {'type': 'opt'})
call minpac#add('morhetz/gruvbox', {'type': 'opt'})
call minpac#add('nightsense/snow', {'type': 'opt'})
call minpac#add('sonph/onehalf', {'name': 'onehalf', 'type': 'opt', 'subdir': 'vim'})
call minpac#add('cocopon/iceberg.vim', {'type': 'opt'})

" Clojure
call minpac#add('guns/vim-clojure-highlight')
call minpac#add('guns/vim-clojure-static')
call minpac#add('guns/vim-sexp')
call minpac#add('kien/rainbow_parentheses.vim')
call minpac#add('tpope/vim-fireplace')
call minpac#add('tpope/vim-salve')
call minpac#add('tpope/vim-sexp-mappings-for-regular-people')
call minpac#add('venantius/vim-cljfmt')

" CSS
call minpac#add('JulesWang/css.vim')

" Go
call minpac#add('fatih/vim-go')

" Elixir
call minpac#add('avdgaag/vim-phoenix')
call minpac#add('elixir-lang/vim-elixir')
call minpac#add('mhinz/vim-mix-format')

" HTML
call minpac#add('mattn/emmet-vim')

" JavaScript
call minpac#add('elzr/vim-json')
call minpac#add('mxw/vim-jsx')
call minpac#add('pangloss/vim-javascript')
call minpac#add('prettier/vim-prettier')

" Kotlin
call minpac#add('udalov/kotlin-vim')

" Markdown
call minpac#add('tpope/vim-markdown')
call minpac#add('nelstrom/vim-markdown-folding')
call minpac#add('junegunn/vim-emoji', {'type': 'opt'})

" Python
call minpac#add('Vimjas/vim-python-pep8-indent')
call minpac#add('lepture/vim-jinja')

" Racket
call minpac#add('wlangstroth/vim-racket')

" Ruby
call minpac#add('tpope/vim-bundler')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-liquid')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rake')
call minpac#add('vim-ruby/vim-ruby')
call minpac#add('slim-template/vim-slim')
call minpac#add('ngmy/vim-rubocop')

" Rust
call minpac#add('rust-lang/rust.vim')

" Writing
call minpac#add('junegunn/goyo.vim')
