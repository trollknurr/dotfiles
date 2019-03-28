if &compatible
  set nocompatible               " Be iMproved
endif


call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/YankRing.vim'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'roxma/nvim-yarp'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'

Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'

Plug 'morhetz/gruvbox'

call plug#end()

filetype plugin indent on
syntax enable

colorscheme gruvbox

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set ignorecase
set smartcase
set hlsearch
set incsearch 

set lazyredraw 
set showmatch 
set showcmd

set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set relativenumber
set hidden

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" set signcolumn=yes

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


" Autocomplete
"

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 0
let g:python3_host_prog = '/home/ashtarev/.envs/nvim/bin/python'

autocmd CompleteDone * pclose

"
"ALE

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\}

let g:ale_linters = {'python': ['flake8', 'mypy']}
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" Keybindings
"
"

" let mapleader = "\<space>"
let mapleader = "\\"
" let maplocalleader = "\<space>"

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap j gj
nnoremap k gk

inoremap jj <esc>

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
