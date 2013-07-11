set hidden
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" " make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set cursorline
" set cmdheight=2
set switchbuf=useopen
set numberwidth=5
"set showtabline=2
set winwidth=79
" " This makes RVM work inside Vim. 
set shell=bash
set backspace=indent,eol,start
" " display incomplete commands
set showcmd
set nocompatible               " be iMproved
filetype off                   " required!

set foldmethod=syntax
set foldlevel=7
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

 Bundle 'gmarik/vundle'

 " My Bundles here:
 Bundle 'tpope/vim-fugitive'
 Bundle 'Lokaltog/vim-easymotion'
 Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
 Bundle 'tpope/vim-rails.git'
 " vim-scripts repos
 Bundle 'L9'
 Bundle 'FuzzyFinder'
 " non github repos
 Bundle 'git://git.wincent.com/command-t.git'
 " ...
 " Bundle 'YouCompleteMe'
Bundle 'vim-tabber'

 filetype plugin indent on     " required!
 filetype plugin on
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
set number
syntax on
:set t_Co=256 " 256 colors
" :set background=dark
" :color grb256
:color codeschool

au BufEnter,BufNew *.py map <F5> :!python %<CR>

command Tweet PosttoTwitter

map <C-up> :tabr<cr>
map <C-down> :tabl<cr>
map <C-left> :tabp<cr>
map <C-right> :tabn<cr>
map <C-n> :tabnew<cr>
map <C-w> :tabclose<cr>

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 9
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

set tabline=%!tabber#TabLine()
set tags=tags;

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
set autochdir
let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>

