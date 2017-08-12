#!/bin/bash

files=( 'oh-my-zsh' 'vim' 'vimrc' 'zshrc' 'screenrc' 'tmux.conf' )

git clone http://github.com/gmarik/vundle.git ./vim/bundle/vundle

for file in "${files[@]}"
do
    echo "Installing $file ..."
    
    rm -rf ~/.$file
    ln -s $(pwd)/$file ~/.$file
done

vim +BundleInstall +GoInstallBinaries +qa

sudo cp {cputemp,cpuusage,memusage} /usr/bin/
