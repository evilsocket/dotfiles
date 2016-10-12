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

if exists('g:loaded_vimrun')
    finish
endif
let g:loaded_vimrun = 1

if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

python << EOF
def py_vimrun():
    import vim
    import os
    import sys

    cwd = vim.eval("getcwd()")
    fname = os.path.join( cwd, '.vimrun' )

    if os.path.isfile(fname):
        data = open( fname, 'rt' ).read()
        vim.command( "!%s" % data)
    else:
        print "No .vimrun file found in current directory."
EOF

function! VimRun()
    python py_vimrun()
endfunction

nmap r :call VimRun()<CR>

