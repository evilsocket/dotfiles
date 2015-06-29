set hidden
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab 
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase       " make searches case-sensitive only if they contain upper-case characters
set cursorline
set switchbuf=useopen
set numberwidth=5
set backspace=indent,eol,start
set showcmd                    " display incomplete commands
set nocompatible               " be iMproved
set fileformats=unix,dos,mac   " support all three, in this order
set foldmethod=syntax
set foldlevel=7

" Initialize vundle runtime
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle package
Bundle 'gmarik/vundle'

" A file tree explorer
Bundle 'scrooloose/nerdtree'
    " Open it on vim startup
    autocmd VimEnter * NERDTree
    " Mirror tree position for every buffer
    autocmd BufEnter * NERDTreeMirror
    " Set current dir to vim cwd
    set autochdir
    let NERDTreeChDirMode=2
    " Ctrl+d to toggle NerdTree
    nmap <silent> <C-D> :NERDTreeToggle<CR> 
    " Close nerdtree when it's the only buffer left open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" A much better statusline
Bundle 'Lokaltog/vim-powerline'
    " Use unicode symbols in powerline
    let g:Powerline_symbols = 'fancy'

" Great configs for Ruby
Bundle 'vim-ruby/vim-ruby'

" Use F9 to fold/unfold
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" By pressing Ctrl + R in the visual mode you will be prompted to enter text to replace with. 
" Press enter and then confirm each change you agree with 'y' or decline with 'n'.
" This command will override your register 'h' so you can choose other one 
" ( by changing 'h' in the command above to other lower case letter ) that you don't use.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

filetype indent on
filetype plugin on

set number
syntax on
set mouse=a
" Force terminal to 256 colors
set t_Co=256
color codeschool 
" Use tabs with Ctrl and arrow keys, Ctrl+n to open a new tab, and Ctrl+w to
" close it
map <C-up> :tabr<cr>
map <C-down> :tabl<cr>
map <C-left> :tabp<cr>
map <C-right> :tabn<cr>
map <C-n> :tabnew<cr>
map <C-w> :tabclose<cr>

" setup for gui
set guioptions-=r  " no scrollbar on the right
set guioptions-=l  " no scrollbar on the left
set guioptions-=m  " no menu
set guioptions-=T  " no toolbar
set guioptions-=L

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 9
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    else
        set guifont=Monaco_for_Powerline
    endif
endif

set tabline=%!tabber#TabLine()
set tags=tags;

" force two spaces indentation for html, ruby and python files
autocmd Filetype html setlocal ts=2 sts=2 sw=2
" autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
" autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
" autocmd Filetype python setlocal ts=2 sts=2 sw=2

:cd $HOME/Desktop/Work
