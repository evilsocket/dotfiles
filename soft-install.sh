#!/bin/bash

files=( 'vimrc' 'zshrc' 'tmux.conf' )

for file in "${files[@]}"
do
    echo "Installing $file ..."
    
    rm -rf ~/.$file
    ln -s $(pwd)/$file ~/.$file
done
