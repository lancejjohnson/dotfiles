" vim: nowrap
scriptencoding utf-8

filetype plugin indent on
syntax on

" Packages
packadd minpac
source ~/.config/nvim/packages.vim

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
" (See https://github.com/k-takata/minpac/blob/master/README.md)
command! PackUpdate call minpac#update()
command! PackClean  call minpac#clean()
command! PackStatus call minpac#status()

" Colors
" set bg=dark
set bg=light

"" Solarized
"" See https://github.com/lifepillar/vimrc/blob/master/vimrc
" if has('termguicolors') && $COLORTERM ==# 'truecolor'
"   set termguicolors
  " let &t_8f = "\<esc>[38;2;%lu;%lu;%lum" " Needed in tmux
  " let &t_8b = "\<esc>[48;2;%lu;%lu;%lum" " Ditto
" endif

" colorscheme solarized8
" colorscheme solarized8_high
" colorscheme solarized8_flat
" colorscheme one

"" Gruvbox
" let g:gruvbox_bold=0
" let g:gruvbox_contrast_light="hard"
" let g:gruvbox_contrast_dark="medium"
" colorscheme gruvbox

"" Nord
" colorscheme nord

"" One Half
colorscheme onehalflight
" colorscheme onehalfdark

"" Typewriter
" colorscheme typewriter
" colorscheme typewriter-night
" Change the cursor from block to i-beam in INSERT mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"
augroup myCmds
  au!
  autocmd VimEnter * silent !echo -ne "\e[1 q"
augroup END

"" Seoul 256
" seoul256 (unified):
" let g:seoul256_background = 233
" let g:seoul256_light_background = 256
" colorscheme seoul256
"
" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"   Default: 253
" let g:seoul256_background = 256
" colorscheme seoul256-light

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
" let g:seoul256_background = 233
" colorscheme seoul256
" set bg=dark
" let g:seoul256_background = 233
" colorscheme seoul256

" Two Firewatch
" colorscheme two-firewatch

" One
" colorscheme one

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

" COC Recommended Configuration
" set cmdheight=2
" set nobackup
" set nowritebackup
" set updatetime=300
" set shortmess+=c
" set signcolumn=yes
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" Display extra whitespace; thoughbot
" set list listchars=tab:»·,trail:·,nbsp:·

" Case-insensitive searching if the search pattern is all lowercase
set ignorecase
set smartcase
set spelllang=en_us
set incsearch

" Line numbers
set number
set relativenumber
function! ToggleRelativeNumber()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
command! ToggleRelativeNumber call ToggleRelativeNumber()
nmap <leader>3 :ToggleRelativeNumber<CR>

" Open new split panes to right and bottom
set splitbelow
set splitright

runtime ftplugin/man.vim
" Matchit - jump to matching keywords in Ruby using %
runtime macros/matchit.vim

"White space
nmap <leader>S :StripWhitespace<CR>
highlight ExtraWhitespace ctermbg=61 guibg=#6c71c4

" Turn off highlighting after search
map <C-n> :nohl<cr>
" Search project for word under cursor
map <leader>\ :Rg <C-R><C-W><CR>

" Autocmds
augroup vimrcEx
  " Clear all autocms in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,elixir set ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml,javascript,sass,python,markdown set colorcolumn=81
  autocmd FileType elixir set colorcolumn=100 foldmethod=syntax foldlevel=99
  " Make ?s part of words (see r00k)
  autocmd FileType elixir,ruby,eruby,yaml set iskeyword+=?
  autocmd FileType elixir,ruby,eruby,yaml set iskeyword+=!
  autocmd FileType elixir,ruby set nomodeline
  autocmd FileType ruby,haml,eruby,yaml,html,slim,javascript,sass,cucumber,elixir,clojure,python autocmd BufWritePre <buffer> StripWhitespace
  autocmd! BufNewFile,BufRead *.md set ft=markdown textwidth=80
  autocmd VimResized * :wincmd =
  " autocmd BufNewFile,BufRead *.py
  "   \ set tabstop=4
  "   \ set softtabstop=4
  "   \ set shiftwidth=4
  "   \ set textwidth=79
  "   \ set expandtab
  "   \ set autoindent
  "   \ set fileformat=unix
augroup END

" tmux
nnoremap <leader>pry :VtrOpenRunner {'orientation': 'v', 'percentage': 30, 'cmd': 'pry'}<cr>

" Omnicomplete
set omnifunc=syntaxcomplete#Complete

" Searching
" Use The Silver Searcher instead of grep
" See http://robots.thoughtbot.com/faster-grepping-in-vim
" if executable('ag')
"   " Use ag over grep
"   set grepprg=ag\ --nogroup\ --nocolor

"   " Use ag in CtrlP for listing files. Lightning fast and respect .gitignore
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
" endif

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

" Alternate Esc
inoremap kj <ESC>

" Sick of accidentally opening help when hitting esc
nnoremap <F1> <nop>
inoremap <F1> <nop>

" NERDTree mapping
let NERDTreeHijackNetrw=1
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
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Rg<Space>

" My vim cheatsheet
map <Leader>vch :e ~/Dropbox/Documents/Software\ Development/Vim/my_vim_cheatsheet.txt<cr>
map <Leader>pn :sp ~/Dropbox/notes/project_notes.txt<cr>

" Indent the whole document and return cursor to staring position
map <Leader>= gg=G''

" Move around splits with <c-hjkl>
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-h> <c-w>h
" nnoremap <c-l> <c-w>l
nnoremap gj <c-w>j
nnoremap gk <c-w>k
nnoremap gh <c-w>h
nnoremap gl <c-w>l

" Make closing a window easier
nnoremap <Leader>c <c-w>c
nnoremap <Leader>q :cclose<cr>

" Make resizing windows easier
if bufwinnr(1)
  map <silent> <A-h> <C-w>>
  map <silent> <A-j> <C-W>+
  map <silent> <A-k> <C-W>-
  map <silent> <A-l> <C-w><
endif

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

" ALE
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=0
let g:ale_lint_on_filetype_changed=0

noremap <leader>x :ALELint<CR>

" Syntastic
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '!'
" let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_ruby_mri_exec = "$RUBY_ROOT/bin/ruby"
" let g:syntastic_ruby_checkers = ['mri', 'rubocop']
" let g:syntastic_elixir_checkers=['elixir']
" let g:syntastic_elixir_elixir_exe = 'elixirc'
" let g:syntastic_mode_map = {
"       \ "mode": "passive",
"       \ "active_filetypes": [],
"       \ "passive_filetypes": [] }

" nnoremap <leader>x :SyntasticCheck<CR>
" nnoremap <leader>r :SyntasticReset<CR>

" NERDTree
let NERDTreeIgnore = ['\.pyc$','\.sublime-workspace','\.sublime-project','\.beam$']

" FZF
nnoremap <leader>f :<C-u>FZF<CR>

" Commands
com! FormatJSON %!python -m json.tool

" Insert a hash rocket
imap <c-l> <space>=><space>

" Insert an Elixir pipe
imap <c-p> \|><space>
imap <c-f> fn<space>-><space>end

function! OpenInOtherEditor(editor)
  let file = @%
  exec(':!'.a:editor.' '.file)
endfunction

command! AtomThis :call OpenInOtherEditor('atom')
command! SublimeThis :call OpenInOtherEditor('subl')
command! CodeThis :call OpenInOtherEditor('code')

function! CopyFilePathToClipboard()
  let @+ = expand("%")
endfunction
nnoremap <leader>r :call CopyFilePathToClipboard()<CR>


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
" let test#strategy = "basic"
let test#strategy = "dispatch"
let test#go#runner = "gotest"
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" React
" let g:jsx_ext_required=0
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

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

" Elixir
nmap <silent> <leader>m :MixFormat<CR>


" golang
let g:go_fmt_command = "goimports"

" JSON
let g:vim_json_syntax_conceal = 0

" Python
let g:python_pep8_indent_hang_closing = 0

" EasyAlign

"" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" NOTE: ctrl-x while in visual mode accepts a regular expresion

"" Align GitHub-flavored Markdown tables
vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" gutentags
" let g:gutentags_file_list_command = 'rg --files'

" airline
" let g:airline_theme = 'solarized'
" let g:bufferline_echo = 0
" let g:airline_powerline_fonts=0
" let g:airline_enable_branch=1
" let g:airline_enable_syntastic=1
" let g:airline_branch_prefix = '⎇ '
" let g:airline_paste_symbol = '∥'
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#branch#displayed_head_limit = 10
