#!/bin/bash

files=( 'oh-my-zsh' 'android' 'bin' 'vim' 'vimrc' 'zshrc' 'tmux.conf' )

for file in "${files[@]}"
do
    echo "Installing $file ..."
    
    rm -rf ~/.$file
    ln -s $(pwd)/$file ~/.$file
done

vim +BundleInstall +qa
