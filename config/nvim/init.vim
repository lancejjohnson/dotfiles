lua require('plugins')
scriptencoding utf-8

filetype plugin indent on " Auto-detect file type, load plugin and indent files for that type
syntax on

runtime ftplugin/man.vim

"" Gruvbox
" let g:gruvbox_bold=0
" let g:gruvbox_contrast_light="hard"
" set bg=light
" colorscheme gruvbox

"" Nord
set termguicolors
colorscheme nord

let mapleader = ","

set autowrite
set backspace=indent,eol,start " Backspace deletes all
set expandtab
set ignorecase
set noswapfile
set nowrap
set number
set relativenumber
set shiftround
set shiftwidth=2
set showmatch
set smartcase
set splitbelow
set splitright
set softtabstop=2
set tabstop=2
set undofile
set undolevels=1000 " max changes that can be undone
set undoreload=10000 "max lines to save for undo on a buffer reload
set visualbell


" Turn off highlighting after search
map <C-n> :nohl<cr>
" Search project for word under cursor
map <leader>\ :Rg <C-R><C-W><CR>

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

" Alternate escape
inoremap kk <ESC>

" Sick of accidentally opening help when hitting esc
nnoremap <F1> <nop>
inoremap <F1> <nop>

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

nnoremap \ :Rg<Space>

" Indent the whole document and return cursor to staring position
map <Leader>= gg=G''

" Move around splits
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

" FZF
nnoremap <leader>f :<C-u>FZF<CR>

" Commands
com! FormatJSON %!jq .

" Insert a hash rocket
imap <c-l> <space>=><space>

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

" vim-test
" let test#strategy = "basic"
let test#strategy = "dispatch"
let test#go#runner = "gotest"
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>


" Elixir
nmap <silent> <leader>m :MixFormat<CR>
imap <c-p> \|><space>
imap <c-f> fn<space>-><space>end

let g:gutentags_file_list_command = 'rg --files'

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

" Line numbers
function! ToggleRelativeNumber()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
command! ToggleRelativeNumber call ToggleRelativeNumber()
nmap <leader>3 :ToggleRelativeNumber<CR>

"White space
nmap <leader>S :StripWhitespace<CR>
highlight ExtraWhitespace ctermbg=61 guibg=#6c71c4

" Turn off highlighting after search
map <C-n> :nohl<cr>
" Search project for word under cursor
map <leader>\ :Rg <C-R><C-W><CR>

augroup vimrcEx
  " Clear all autocms in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,elixir set autoindent sw=2 sts=2 expandtab
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

