import vim
import os

cwd = vim.eval("getcwd()")
fname = os.path.join( cwd, '.vimrun' )

if os.path.isfile(fname):
    data = open( fname, 'rt' ).read()
    vim.command( "!%s" % data)
else:
    print "No .vimrun file found in current directory."
