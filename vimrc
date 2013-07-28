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
set backspace=indent,eol,start
" " display incomplete commands
set showcmd
set nocompatible               " be iMproved
filetype off                   " required!
set fileformats=unix,dos,mac   " support all three, in this order

set foldmethod=syntax
set foldlevel=7

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

filetype plugin indent on
filetype plugin on

set number
syntax on
set mouse=a
:set t_Co=256 " 256 colors
:color mustang

set guioptions-=r  " no scrollbar on the right
set guioptions-=l  " no scrollbar on the left
set guioptions-=m  " no menu
set guioptions-=T  " no toolbar

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
    else
        set guifont=Monaco
    endif
endif

set tabline=%!tabber#TabLine()
set tags=tags;

" configure omni completion
if has("autocmd") && exists("+omnifunc") 
autocmd Filetype * 
    \	if &omnifunc == "" | 
    \	 setlocal omnifunc=syntaxcomplete#Complete | 
    \	endif 
    endif 

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
set autochdir
let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>
nmap <silent> <C-D> :NERDTreeToggle<CR> " Ctrl+d to toggle NerdTree

