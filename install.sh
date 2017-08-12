#!/bin/bash

git clone http://github.com/gmarik/vundle.git ./data/vim/bundle/vundle

for file in data/*
do
    echo "Installing $file ..."
    
    rm -rf ~/.$(basename $file)
    ln -s $(pwd)/$file ~/.$(basename $file)
done

vim +BundleInstall +GoInstallBinaries +qa

echo 
echo "Make sure to install lm-sensors and gawk before executing screen."
echo
