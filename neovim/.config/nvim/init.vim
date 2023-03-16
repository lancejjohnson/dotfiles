lua require("lance.manifest")
scriptencoding utf-8

filetype plugin indent on
syntax on

runtime ftplugin/man.vim

"" Gruvbox
" set termguicolors
" let g:gruvbox_bold=0
" let g:gruvbox_contrast_light="hard"
" set bg=light
" colorscheme gruvbox
"" end Gruvbox

"" Nord
set termguicolors
colorscheme nord
"" end Nord

"" Xcode
" set termguicolors
" let g:green_comments=0
" set bg=light
" colorscheme xcodelight
"" end Xcode

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
set undolevels=1000
set undoreload=10000
set visualbell
set winwidth=105

" Autoclose html tags with </
iabbrev </ </<C-X><C-O>

" Commands
" Replaced by LSP
" com! FormatJSON %!jq .

" Ctags
" let g:gutentags_file_list_command = 'rg --files'

" golang
let g:go_fmt_command = "goimports"

" JSON
let g:vim_json_syntax_conceal = 0

" Python
let g:python_pep8_indent_hang_closing = 0

highlight ExtraWhitespace ctermbg=61 guibg=#6c71c4

augroup vimrcEx
  " Clear all autocms in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,elixir set autoindent sw=2 sts=2 expandtab
  autocmd FileType ruby,eruby,yaml,javascript,sass,python,markdown set colorcolumn=81
  autocmd FileType java set colorcolumn=101
  autocmd FileType elixir,rust set colorcolumn=100 foldmethod=syntax foldlevel=99
  " Make ?s part of words (see r00k)
  autocmd FileType elixir,ruby,eruby,yaml set iskeyword+=?
  autocmd FileType elixir,ruby,eruby,yaml set iskeyword+=!
  autocmd FileType elixir,ruby set nomodeline
  autocmd FileType rust,ruby,haml,eruby,yaml,html,slim,javascript,sass,cucumber,elixir,clojure,python autocmd BufWritePre <buffer> StripWhitespace
  autocmd! BufNewFile,BufRead *.md set ft=markdown textwidth=80

  au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
  au BufRead,BufNewFile mix.lock set filetype=elixir

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

function! ToggleRelativeNumber()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
command! ToggleRelativeNumber call ToggleRelativeNumber()
nmap <leader>3 :ToggleRelativeNumber<CR>

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

set completeopt=menu,menuone,noselect

