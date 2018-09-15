" General
if 0 | endif
set encoding=utf-8
set fileencodings=utf-8
scriptencoding utf-8
language en_US

augroup MyAutoCmd
    autocmd!
augroup END

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

function! s:load(file) abort
    let s:path = expand('$CONFIG/nvim/rc/' . a:file . '.vim')

    if filereadable(s:path)
        execute 'source' fnameescape(s:path)
    endif
endfunction

call s:load('plugins')

" Options
set number
set whichwrap+=b,s,h,l,<,>,~,[,]
set incsearch
set ignorecase
set smartcase
set scrolloff=5
set display+=lastline
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set noswapfile
set nobackup
set clipboard+=unnamed
set noshowmode

" Color
syntax on
colorscheme molokai

" Mappings
nnoremap <silent><C-e> :NERDTreeToggle<CR>
