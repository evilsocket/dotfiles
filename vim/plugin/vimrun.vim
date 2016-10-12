" ============================================================================
" File:        vimrun.vim
" Description: plugin which executes .vimrun file (if exists in current
" folder) when 'r' is pressed in normal mode.
" Maintainer:  Simone Margaritelli <evilsocket at gmail dot com>
" Last Change: 12 October 2016
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can
"              redistribute
"              it and/or modify it under the terms of the Do What The Fuck
"              You Want To Public License, Version 2, as published by Sam
"              Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
" ============================================================================

" If python is available, execute vimrun.py on current folder,
" the command will search for a .vimrun file and execute it as
" a command if 'r' is pressend in normal mode.
if has('python')
    function! VimRun()
        pyfile ~/.vim/plugin/vimrun.py
    endfunction

    nmap r :call VimRun()<CR>
endif

