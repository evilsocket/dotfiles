#!/bin/bash
bold=$(tput bold)
norm=$(tput sgr0)

PACKAGES=( 
  htop
  ack
  git
  vim-nox
  lm-sensors 
  gawk 
  zsh
  screen
  tmux
  golang
)

clear 

echo "Make sure to install ${bold}${PACKAGES[*]}${norm}, then ${bold}chsh -s $(which zsh)${norm} and press ENTER when done."
read
 
for file in data/*
do
    echo "Linking $file to ${bold}~/.$(basename $file)${norm} ..."
    rm -rf ~/.$(basename $file)
    ln -s $(pwd)/$file ~/.$(basename $file)
done

if [ ! -d ./data/vim/bundle/vundle ]; then
    git clone http://github.com/gmarik/vundle.git ./data/vim/bundle/vundle
fi

vim +BundleInstall +GoInstallBinaries +qa
