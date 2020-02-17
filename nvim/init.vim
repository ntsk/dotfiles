" General
if 0 | endif
set encoding=utf-8
set fileencodings=utf-8
scriptencoding utf-8
language en_US.UTF-8

augroup MyAutoCmd
    autocmd!
    autocmd FileType vue syntax sync fromstart
    autocmd BufNewFile,BufRead *.dig set filetype=yaml
    autocmd BufNewFile,BufRead *.vue setlocal filetype=vue
    autocmd BufNewFile,BufRead Dangerfile set filetype=ruby
    autocmd BufNewFile,BufRead Fastfile set filetype=ruby
    autocmd BufNewFile,BufRead *hql set filetype= hive
    autocmd BufNewFile,BufRead *.q set filetype=hive
    " keep cursor's position after buffer switch
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" Dir
let g:python_host_prog = $PYENV_ROOT . '/shims/python'
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

let s:vimcache_dir   = expand('$HOME/.cache/nvim')
let s:viminfo        = s:vimcache_dir.'/viminfo'
let s:backup_dir     = s:vimcache_dir.'/backup'
let s:swap_dir       = s:vimcache_dir.'/swap'
let s:undo_dir       = s:vimcache_dir.'/undo'
let s:view_dir       = s:vimcache_dir.'/view'

function! s:make_dir(dir) abort
  if !isdirectory(a:dir)
    call mkdir(a:dir, 'p')
  endif
endfunction
call s:make_dir(s:vimcache_dir)
call s:make_dir(s:backup_dir)
call s:make_dir(s:swap_dir)
call s:make_dir(s:undo_dir)
call s:make_dir(s:view_dir)

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set clipboard+=unnamed,unnamedplus
set mouse=a
set noshowmode
set tags+=$HOME/tags

" Cache
set backup
execute 'set backupdir='.s:backup_dir

set swapfile
execute 'set directory='.s:swap_dir

set undofile
execute 'set undodir='.s:undo_dir

set viewoptions-=options
execute 'set viewdir='.s:view_dir
execute 'set viminfo+=n'.s:viminfo

" Color
syntax on
colorscheme molokai

" Mappings
nnoremap <silent><C-e> :NERDTreeToggle<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
