#!/bin/bash
bold=$(tput bold)
norm=$(tput sgr0)


#noobslab/themes 
#noobslab/icons
PPAS=(
   nilarimogard/webupd8
   webupd8team/java 
)


#unity-tweak-tool
#arc-theme
#arc-icons
#grive
PACKAGES=( 
  htop 
  cryptsetup
  oracle-java8-installer
  ack
  git
  vim-nox
  lm-sensors 
  gawk 
  zsh
  screen
  tmux
  golang
  build-essential 
  libpcap-dev
  libnetfilter-queue-dev
)

COMMANDS=(
    'chsh -s /usr/bin/zsh'
)

clear 

echo "Suggested commands before you continue:"
echo
for ppa in "${PPAS[@]}"
do
    echo "  sudo add-apt-repository ${bold}ppa:$ppa${norm}"
done
echo "  sudo apt-get update"
echo 
echo "  sudo apt-get install ${bold}${PACKAGES[*]}${norm} -y"
echo 
for cmd in "${COMMANDS[@]}"
do
    echo "  ${bold}$cmd${norm}"
done
echo

read
 
for file in data/*
do
    echo "Linking $file to ${bold}~/.$(basename $file)${norm} ..."
    rm -rf ~/.$(basename $file)
    ln -s $(pwd)/$file ~/.$(basename $file)
done

touch ~/.priv.env

if [ ! -d ./data/vim/bundle/vundle ]; then
    git clone http://github.com/gmarik/vundle.git ./data/vim/bundle/vundle
fi

# needed to install golang tools for vim
mkdir -p ~/gocode/
vim +BundleInstall +GoInstallBinaries +qa
