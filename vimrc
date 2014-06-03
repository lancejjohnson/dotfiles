" Vundle
set nocompatible
filetype off      " required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jiangmiao/auto-pairs'
Plugin 'wincent/Command-T'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-cucumber'
Plugin 'tomtom/tcomment_vim'
Plugin 'vim-ruby/vim-ruby'

" Vundle Plugins go here ...
call vundle#end()
filetype plugin indent on   " require
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"Pathogen
"execute pathogen#infect()
syntax on

" Matchit - allows jumping to matching keywords (e.g. do, end in Ruby) using
" the %
runtime macros/matchit.vim

" Appearance
set guifont=Inconsolata-dz:h14
"set background=light

colorscheme solarized
"colorscheme Tomorrow-Night-bright

set encoding=utf-8
set showmode
set showcmd
set wildmenu
set ruler
runtime ftplugin/man.vim
set autoindent
set laststatus=2        " Always show status line
set autowrite           " Automatically :write before running commands
set noswapfile

"White space
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

"Backspace deletes all
set backspace=indent,eol,start

" Search
set nowrap
set hlsearch
set showmatch
"Allow for case-insensitive searching if the search pattern is all lowercase
set ignorecase
set smartcase
set spelllang=en_us
set incsearch
set number
" See Practical Vim pp. 272-273 for ack commands
set grepprg=ack\ --nogroup\ $* "Use ack instead of grep
set grepformat=%f:%l:%c:%m

" The Silver Searcher
"let g:ackprg = 'ag --nogroup --nocolor --column'

" Handle persistent undo
set undofile
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set hidden
set visualbell

let mapleader = ","

"Kill the arrow keys in normal mode to force movement keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Highlight trailing whitespace
match ErrorMsg /\s\+\%#\@<!$/

"Make ,W strip trailing whitespace (see stevelosh.com Coming Home to Vim)
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"NERDTree mapping
nmap <leader>nt :NERDTreeToggle<CR>

"Command-T mapping
nmap <leader>t :CommandT<CR>
let g:CommandTMaxFiles=50000

" Ctrl-p
nmap <leader>p :CtrlP<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Ctags
set tags=./tags,tags;$HOME
"nnoremap <f5> :!ctags -R<CR> " Map F5 to update ctags
"autocmd BufWritePost * call system("ctags -R")

"Cucumber syntax
au Bufread,BufNewFile *.feature set filetype=gherkin
au! Syntax gherkin source ~/.vim/syntax/cucumber.vim

" Markdown syntax - These don't actually set the syntax correctly
"autocmd BufNewFile,BufReadPost *.md set syntax=markdown
"au! Syntax markdown

