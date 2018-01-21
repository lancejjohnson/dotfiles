" vim: nowrap
scriptencoding utf-8

filetype plugin indent on
syntax on

" Packages
packadd minpac
source ~/.packages.vim

" GUI settings
set guioptions-=r     " Hide right scroll bar in MacVim
set guioptions-=L     " Hide left scroll bar in MacVim
set guioptions-=e     " Use non-gui tabs
set guifont=Fira\ Mono:h16

" UI settings
set termguicolors
set background=dark
let g:solarized_bold=0
let g:solarized_italic=0
" let g:solarized_termcolors=16
" silent! colorscheme solarized
" Want to compare this with normal solarized
silent! colorscheme solarized8_dark

" General settings
let mapleader = ","

set autoindent
set autoread
set autowrite
set backspace=indent,eol,start " Backspace deletes all
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set laststatus=2
set nojoinspaces
set noswapfile
set nowrap
set ruler
set shiftround
set shiftwidth=2
set showcmd
set showmatch
set showmode
set softtabstop=2
set tabstop=2
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "max changes that can be undone
set undoreload=10000 "max lines to save for undo on a buffer reload
set visualbell
set wildmenu
set winwidth=105

" Case-insensitive searching if the search pattern is all lowercase
set ignorecase
set smartcase
set spelllang=en_us
set incsearch

" Line numbers
set number
set relativenumber

" Open new split panes to right and bottom
set splitbelow
set splitright

runtime ftplugin/man.vim
" Matchit - jump to matching keywords in Ruby using %
runtime macros/matchit.vim

"White space
nmap <leader>S :StripWhitespace<CR>
highlight ExtraWhitespace ctermbg=61 guibg=#6c71c4

function! ToggleRelativeNumber()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
command! ToggleRelativeNumber call ToggleRelativeNumber()


" Turn off highlighting after search
map <C-n> :nohl<cr>
" Search project for word under cursor
map <leader>\ :Ag <C-R><C-W> -Q<CR>


" Autocmds
augroup vimrcEx
  " Clear all autocms in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,elixir set ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml,javascript,sass set colorcolumn=80,100
  autocmd FileType elixir set colorcolumn=80,100 foldmethod=syntax foldlevel=99
  " Make ?s part of words (see r00k)
  autocmd FileType elixir,ruby,eruby,yaml set iskeyword+=?
  autocmd FileType elixir,ruby,eruby,yaml set iskeyword+=!
  autocmd FileType elixir,ruby set nomodeline
  autocmd FileType ruby,haml,eruby,yaml,html,slim,javascript,sass,cucumber,elixir,clojure autocmd BufWritePre <buffer> StripWhitespace
  autocmd! BufNewFile,BufRead *.md set ft=markdown
augroup END

" Omnicomplete
set omnifunc=syntaxcomplete#Complete

" Searching
" Use The Silver Searcher instead of grep
" See http://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respect .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Key Mapping and Bindings

" Kill the arrow keys in normal mode to force movement keys
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

" Sick of accidentally opening help when hitting esc
nnoremap <F1> <nop>
inoremap <F1> <nop>

" NERDTree mapping
nmap <leader>n :NERDTreeToggle<CR>

" Ctags
set tags=./tags,tags;$HOME
function! UpdateTags()
  exec ":!ctags -R"
  " let f = expand("~/.ctagsignore")
  " if filereadable(f)
  "   exec ":!ctags -R --exclude=".f
  " else
  "   exec ":!ctags -R --exclude=node_modules --exclude=vendor"
  " endif
endfunction
nnoremap <f5> :call UpdateTags()<CR><CR>

" Make saving easier
nnoremap <Leader>w :w<CR>
nmap :W :w<CR>

" Speed up system clipboard (http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/)
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" bind \ to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<Space>

" My vim cheatsheet
map <Leader>vch :e ~/Dropbox/Documents/Software\ Development/Vim/my_vim_cheatsheet.txt<cr>
map <Leader>pn :sp ~/Dropbox/notes/project_notes.txt<cr>

" Indent the whole document and return cursor to staring position
map <Leader>= gg=G''

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Make closing a window easier
nnoremap <Leader>c <c-w>c
nnoremap <Leader>q :cclose<cr>

" Shift Enter adds new line above cursor
imap <S-CR> <C-o><S-o>

" Autoclose html tags with </
iabbrev </ </<C-X><C-O>


" MULTIPURPOSE TAB KEY - Stolen shamelessly from Gary Bernhardt
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Syntastic
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_javascript_jshint_args = '--config ~/.jshintrc'
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_ruby_mri_exec = "$RUBY_ROOT/bin/ruby"
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_elixir_checkers=['elixir']
let g:syntastic_elixir_elixir_exe = 'elixirc'
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": [] }

" NERDTree
let NERDTreeIgnore = ['\.pyc$','\.sublime-workspace','\.sublime-project','\.beam$']

" CtrlP
nmap <leader>t :CtrlP<cr>
" Allow multiple instances of the same file to be opened by ctrlp
let g:ctrlp_switch_buffer = 0 " default is 'Et'

" Commands
com! FormatJSON %!python -m json.tool

" Insert a hash rocket
imap <c-l> <space>=><space>

" Insert an Elixir pipe
imap <c-p> \|><space>

function! OpenInOtherEditor(editor)
  let file = @%
  exec(':!'.a:editor.' '.file)
endfunction

command! AtomThis :call OpenInOtherEditor('atom')
command! SublimeThis :call OpenInOtherEditor('subl')

" Rubocop
let g:vimrubocop_config = "$HOME/source/style-guides/ruby/.rubocop.yml"
" function! UseRentPathRubocop()
"   let l:rp_rubocop_config = expand("~") . "/source/style-guides/ruby/.rubocop.yml"
"   echo l:rp_rubocop_config
"
"   if filereadable(l:rp_rubocop_config)
"     let g:vimrubocop_config = l:rp_rubocop_config
"   endif
" endfunction
" autocmd! BufReadPost,BufNewFile * call UseRentPathRubocop()

" vim-test
let test#strategy = "basic"
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>"

" React
let g:jsx_ext_required=0

" Clojure
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

" EasyAlign

"" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" NOTE: ctrl-x while in visual mode accepts a regular expresion

"" Align GitHub-flavored Markdown tables
vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
