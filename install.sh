#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
git submodule update --init --recursive

rm -rf ./vim/bundle/*
git clone http://github.com/gmarik/vundle.git ./vim/bundle/vundle

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="vimrc vim zshrc oh-my-zsh"    # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
rm -rf $olddir
mkdir -p $olddir

# Change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do 
    echo "~/.$file -> $olddir"
    mv ~/.$file $olddir
    echo "$dir/$file -> ~/.$file"
    ln -s $dir/$file ~/.$file
done

# install vim bundles
vim +BundleInstall +qa
